class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :name_en
      t.timestamps
    end
    add_index :areas, :name
  end
end
