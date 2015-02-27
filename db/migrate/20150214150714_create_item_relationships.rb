class CreateItemRelationships < ActiveRecord::Migration
  def change
    create_table :item_relationships do |t|
      t.integer :item_id
      t.integer :sub_item_id

      t.timestamps null: false
    end
  end
end
