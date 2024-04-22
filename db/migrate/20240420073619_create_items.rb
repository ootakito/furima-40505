class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false

      # Active Hashを使用する列
      t.integer :category_id, null: false
      t.integer :condition_id, null: false
      t.integer :shipping_cost_burden_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :shipping_duration_id, null: false

      # 通常の外部キー制約を使用する列
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
