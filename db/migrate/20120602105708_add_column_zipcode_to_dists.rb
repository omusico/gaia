class AddColumnZipcodeToDists < ActiveRecord::Migration
  def change
    add_column :dists, :zipcode, :integer, :after => :name
    add_index :dists, :zipcode
  end
end
