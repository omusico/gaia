shared_examples_for "api_data_city" do
  describe "api data hash of city" do
    before do
    end
    
    it { @city_hash.should be_a_kind_of(Hash) }
    
    it "city id" do
      if @city
        @city_hash[:id].to_i.should == @city.id
      else
        @city_hash.key?(:id).should be_true
      end
    end
    
    it "city name" do
      if @city
        @city_hash[:name].should == @city.name 
      else
        @city_hash.key?(:name).should be_true
      end
    end
    
    it { @city_hash[:name_aliases].should be_a_kind_of(Array) }
    
    
    describe "dists" do
      before do
        @dists = @city_hash[:dists]
      end
      it_should_behave_like "api_data_dists"
      
      describe "dist" do
        before do
          @dist_hash = @dists.first
        end
        it_should_behave_like "api_data_dist"
      end
    end
    
    it "name aliases enabled only" do
      alias_ids = @city_hash[:name_aliases].map{ |hash| hash[:name] }
      alias_ids.include?(@city_name_alias_enabled.name).should be_true
      alias_ids.include?(@city_name_alias_disabled.name).should be_false
    end
  end
end