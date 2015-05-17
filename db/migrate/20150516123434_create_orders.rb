class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :invoice, index: true

      t.timestamps null: false
    end
    add_foreign_key :orders, :invoices
  end
end
