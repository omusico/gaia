shared_examples_for "api_data_dists" do
  describe "api data hash of dists" do
    before do
      @city_id = @city.id if @city && !@city_id
    end
    
    it { @dists.should be_a_kind_of(Array) }
    it "should only include enabled if enabled" do
      dist_ids = @dists.map{ |h| h[:id].to_i }
      dist_ids.include?(@dist_enabled.id).should be_true
      dist_ids.include?(@dist_disabled.id).should be_false
    end
    it "should only belongs to city if city_id" do
      if @city_id
        @dists.each do |dist_hash|
          if dist_hash[:city_id]
            dist_hash[:city_id].to_i.should == @city_id.to_i
          end
        end
      end
    end
  end
end