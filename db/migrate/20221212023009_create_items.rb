class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.integer :excluded_price, null: false
      t.text :caption, null: false
      t.boolean :is_status, null: false, default: true
      t.timestamps
    end
  end
end
