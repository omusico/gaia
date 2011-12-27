shared_examples_for "api_data_dist" do
  describe "api data hash of dist" do
    before do
      @city_id = @city.id if @city && !@city_id
      @city_name = @city.name if @city && !@city_name
    end
    
    it { @dist_hash.should be_a_kind_of(Hash) }
    it { @dist_hash[:id].to_i.should == @dist.id }
    it { @dist_hash[:name].should be_a_kind_of(String) }
    
    it "check city id" do 
      if @city_id && @dist_hash[:city_id]
        @dist_hash[:city_id].should == @city_id
      end
    end
    
    it "check city name" do 
      if @dist_hash[:city]
        @dist_hash[:city].key?(:name).should be_true
        if @city_name
          @dist_hash[:city][:name].should == @city_name
        end
      end
    end
    
    it "check city name_aliases" do
      if @dist_hash[:city]
        @dist_hash[:city][:name_aliases].should be_a_kind_of(Array)
      end
    end
    
    it { @dist_hash[:name_aliases].should be_a_kind_of(Array) }
    it "name aliases enabled only" do
      alias_ids = @dist_hash[:name_aliases].map{ |hash| hash[:name] }
      alias_ids.include?(@dist_name_alias_enabled.name).should be_true
      alias_ids.include?(@dist_name_alias_disabled.name).should be_false
    end
  end
end