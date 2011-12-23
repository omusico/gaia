class CreateDistNameAliases < ActiveRecord::Migration
  def change
    create_table :dist_name_aliases do |t|
      t.string :name
      t.integer :dist_id
      t.boolean :is_enabled
      t.timestamps
    end

    add_index :dist_name_aliases, :is_enabled
    add_index :dist_name_aliases, :dist_id
    add_index :dist_name_aliases, [:dist_id,:name], :unique => true

  end
end
