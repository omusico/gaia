class CreateDists < ActiveRecord::Migration
  def change
    create_table :dists do |t|
      t.integer :city_id
      t.string :name
      t.boolean :is_enabled
      t.timestamps
    end
    
    add_index :dists, :is_enabled
    add_index :dists, :city_id
    add_index :dists, [:name,:city_id], :unique => true
  end
end
