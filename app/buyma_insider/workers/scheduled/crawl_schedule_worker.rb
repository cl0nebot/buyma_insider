require 'slackiq'
require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/time/calculations'

##
#
# Will take all the merchants crawler,
# compute the average of the current time they takes
# to run, then schedule them so they can
# finish on time, e.g. before 6 a.m.
#
class CrawlScheduleWorker < Worker::Base
  recurrence { daily.hour_of_day(20) }

  def initialize
    @start_time = Time.now.beginning_of_day.tomorrow + 1.hour
  end

  def perform
    merchant_scores = Merchant::Base.all.map { |merchant|
      metadatum = merchant.metadatum
      [merchant, metadatum.crawl_sessions
                   .map(&:elapsed_time)
                   .compact
                   .inject(0) { |m, n| (m + n)/2 }]
    }

    merchant_scores = merchant_scores.sort_by(&:last) # sort_by array's last, which is the elapsed time
    merchant_scores.each do |merchant, _elapsed_time|
      CrawlWorker.perform_at @start_time, merchant.name
      Slackiq.notify webhook_name: :worker,
                     title:        %(#{merchant.name.capitalize} crawler scheduled to start @ #{@start_time.strftime('%F %T')})

      @start_time += 30.minutes
    end
  end
end