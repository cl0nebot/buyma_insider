class CrawlHistory
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include Serializable

  belongs_to :crawl_session, index: true
  
  belongs_to :merchant, index: true
  
  # default_scope { order_by(created_at: :asc) }

  alias_method :started_at, :created_at

  field :id,                  primary_key: true, required: true
  field :status,              type: Enum, default: :scheduled, in: %i(scheduled inprogress aborted completed)
  field :link,                type: String, required: true, length: (1..1000), format: %r(//.*)
  field :description,         type: String, required: true
  field :items_count,         type: Integer, default: 0
  field :invalid_items_count, type: Integer, default: 0
  field :traffic_size_kb,     type: Float, default: 0.0 # Traffic used
  field :finished_at,         type: Time
  
  default_scope { order_by(created_at: :desc) }
end