class ConvertAreaDatas < ActiveRecord::Migration
  def up
    [["北", "north"], ["中", "middle"], ["南", "south"], ["東", "east"], ["離島", "islands"]].each do |datas|
      a = Area.find_or_create_by_name(datas.first)
      a.update_column :name_en, datas.last
    end
    {"北" => ["臺北市", "新北市", "桃園縣", "新竹縣", "基隆市", "新竹市"],
     "中" => ["苗栗縣", "彰化縣", "臺中市", "南投縣", "雲林縣"],
     "南" => ["嘉義市", "嘉義縣", "臺南市", "高雄市", "屏東縣"],
     "東" => ["宜蘭縣", "花蓮縣", "臺東縣"], 
     "離島" => ["澎湖縣", "金門縣", "連江縣"]
    }.each do |area_name, citie_names|
      area = Area.find_by_name(area_name)
      citie_names.each do |city_name|
        city = City.find_by_name(city_name)
        city.update_attributes :area => area
        city.dists.each do |dist|
          dist.update_attributes :area => area
        end 
      end
    end
  end

  def down
  end
end
