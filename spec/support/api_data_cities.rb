shared_examples_for "api_data_cities" do
  describe "api data hash of cities" do
    it { @cities.should be_a_kind_of(Array) }
    it "should only include enabled if enabled" do
      ids = @cities.map{ |h| h[:id].to_i }
      ids.include?(@city_enabled.id).should be_true
      ids.include?(@city_disabled.id).should be_false
    end
    
    describe "city" do
      before do
        @city_hash = @cities.first
      end
      it_should_behave_like "api_data_city"
    end
  end
end