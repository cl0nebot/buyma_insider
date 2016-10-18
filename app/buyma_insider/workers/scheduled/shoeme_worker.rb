##
# Shoeme
#
class ShoemeWorker < CrawlerWorkerBase
  recurrence {
    daily
      .hour_of_day(3)
      .minute_of_hour(30)
  }

  def initialize
    @merchant = ::Shoeme.new
  end
end
