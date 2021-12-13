class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.integer :amount
      t.string :origin
      t.datetime :sale_date

      t.timestamps
    end
  end
end
