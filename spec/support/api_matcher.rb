module ApiMatcher
  def it_should_be_areas(areas, matched_area: nil)
    areas.should be_a_kind_of(Array)
    ids = areas.map{ |a| a[:id] }
    it_should_be_area(areas.select{ |a| a[:id] == matched_area.id }.first, :area => matched_area) if matched_area
    areas.each{ |area_hash| it_should_be_area(area_hash, {}) }
  end

  def it_should_be_area(area_hash, area: nil)
    area_hash.should be_a_kind_of(Hash)
    area_hash.key?(:id).should be_true
    area_hash.key?(:name).should be_true
    area_hash.key?(:name_en).should be_true
    if area
      area_hash[:id].to_i.should == area.id
      area_hash[:name].should == area.name 
      area_hash[:name_en].should == area.name_en
    end
    if area_hash.key?(:cities)
      City.disabled.each do |disabled_city|
        area_hash[:cities].select{ |city_hash| city_hash[:id].to_i == disabled_city.id }.size.should == 0
      end

      area_hash[:cities].each do |city_hash|
        it_should_be_city(city_hash, :area => area)
      end
    end
  end

  def it_should_be_cities(cities, matched_city: nil, area: nil)
    cities.should be_a_kind_of(Array)
    ids = cities.map{ |c| c[:id] }
    ids.include?(matched_city.id).should be_true if matched_city
    City.disabled.each do |disabled_city|
      ids.include?(disabled_city.id).should be_false
    end
    cities.each{ |city_hash| city_hash[:area_id].should == area.id } if area
    cities.each{ |city_hash| city_hash.key?(:area).should be_true }
    cities.each{ |city_hash| it_should_be_city(city_hash, {}) }
  end

  def it_should_be_city(city_hash, city: nil, area: nil)
    city_hash.should be_a_kind_of(Hash)
    city_hash.key?(:id).should be_true
    city_hash.key?(:name).should be_true
    city_hash.key?(:pure_name).should be_true
    city_hash.key?(:type_name).should be_true
    it_should_be_area(city_hash[:area], {}) if city_hash.key?(:area)
    if city
      city_hash[:id].to_i.should == city.id
      city_hash[:name].should == city.name 
      city_hash[:pure_name].should == city.pure_name
      city_hash[:type_name].should == city.type_name
    end
    if city_hash.key?(:dists)
      Dist.disabled.each do |disabled_dist|
        city_hash[:dists].select{ |dist_hash| dist_hash[:id].to_i == disabled_dist.id }.size.should == 0
      end
    end
  end

  def it_should_be_dists(dists, matched_dist: nil, city: nil, area: nil)
    dists.should be_a_kind_of(Array)
    ids = dists.map{ |c| c[:id] }
    ids.include?(matched_dist.id).should be_true if matched_dist
    Dist.disabled.each do |disabled_dist|
      ids.include?(disabled_dist.id).should be_false
    end
    dists.each do |dist_hash| 
      dist_hash[:area_id].should == area.id  if area
      dist_hash[:city_id].should == city.id  if city
      it_should_be_city(dist_hash[:city]) if dist_hash.key?(:city)
      it_should_be_dist(dist_hash, :city => city, :area => area)
    end
  end

  def it_should_be_dist(dist_hash, dist: nil, city: nil, area: nil)
    dist_hash.should be_a_kind_of(Hash)
    dist_hash.key?(:id).should be_true
    dist_hash.key?(:name).should be_true
    dist_hash.key?(:pure_name).should be_true
    dist_hash.key?(:type_name).should be_true
    dist_hash.key?(:zipcode).should be_true
    if dist
      dist_hash[:id].to_i.should == dist.id
      dist_hash[:name].should == dist.name 
      dist_hash[:pure_name].should == dist.pure_name
      dist_hash[:type_name].should == dist.type_name
      dist_hash[:zipcode].should == dist.zipcode
    end
    if dist_hash.key?(:city)
      it_should_be_city(dist_hash[:city], :city => city, :area => area)
    else
      dist_hash.key?(:city_id).should be_true
      dist_hash[:city_id].should == city.id if city
    end
  end

  def it_should_be_name_alias(name_list, city: nil, dist: nil)
    name_list.should be_a_kind_of(Array)
    if city
      name_enabled = city.name_aliases.first
      name_disabled = city.all_name_aliases.disabled.first
      name_list.include?(name_enabled.name).should be_true if name_enabled
      name_list.include?(name_disabled.name).should be_false if name_disabled
    end
    if dist
      name_enabled = dist.name_aliases.first
      name_disabled = dist.all_name_aliases.disabled.first
      name_list.include?(name_enabled.name).should be_true if name_enabled
      name_list.include?(name_disabled.name).should be_false if name_disabled
    end
  end
end