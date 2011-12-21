class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.boolean :is_enabled
      t.timestamps
    end
    
    add_index :cities, :is_enabled
    add_index :cities, :name, :unique => true
  end
end
