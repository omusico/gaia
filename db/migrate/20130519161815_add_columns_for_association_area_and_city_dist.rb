class AddColumnsForAssociationAreaAndCityDist < ActiveRecord::Migration
  def up
    add_column :dists, :area_id, :integer, :after => :city_id
    add_column :cities, :area_id, :integer, :after => :name
    add_index :dists, :area_id
    add_index :cities, :area_id
  end

  def down
  end
end
