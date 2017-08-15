class CreateCrawlHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :crawl_histories do |t|
      t.references :index_page, null: false

      t.integer :status, null: false
      t.text :description, null: false, limit: 2000
      t.integer :article_created_count, default: 0
      t.integer :article_updated_count, default: 0
      t.integer :article_count, default: 0
      t.integer :article_invalid_count, default: 0
      t.float :traffic_size_in_kb, default: 0.0
      t.text :response_headers, null: false, limit: 2000
      t.integer :response_status, null: false
      t.datetime :finished_at

      t.timestamps null: false
    end

    add_index :crawl_histories, :finished_at, order: { finished_at: :desc }

    add_foreign_key :crawl_histories, :index_pages
  end
end