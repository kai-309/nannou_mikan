class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :admin_id
      t.integer :excluded_price, null: false
      t.text :caption, null: false
      t.boolean :is_status, null: false, default: true
      t.timestamps
    end
  end
end
