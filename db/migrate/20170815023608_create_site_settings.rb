class CreateSiteSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :site_settings do |t|
      t.hstore :settings, null: false

      t.timestamps null: false
    end
  end
end
