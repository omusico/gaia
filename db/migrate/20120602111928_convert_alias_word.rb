# encoding: utf-8
class ConvertAliasWord < ActiveRecord::Migration
  def up
    Dist.find_each do |dist|
      if dist.name.index("臺")
        dist.name_aliases.create(:name => dist.name.gsub("臺", "台"), :is_enabled => true)
      end
    end
    ZipcodeParser.parse_zipcode
  end

  def down
  end
end
