class CreateCityNameAliases < ActiveRecord::Migration
  def change
    create_table :city_name_aliases do |t|
      t.string :name
      t.integer :city_id
      t.boolean :is_enabled
      t.timestamps
    end
    
    add_index :city_name_aliases, :is_enabled
    add_index :city_name_aliases, :city_id
    add_index :city_name_aliases, [:city_id,:name], :unique => true
    
  end
end
