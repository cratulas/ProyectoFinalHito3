class AddAtributesToVeterinaries < ActiveRecord::Migration[5.2]
  def change
    add_column :veterinaries, :name, :string
    add_column :veterinaries, :description, :text
  end
end
