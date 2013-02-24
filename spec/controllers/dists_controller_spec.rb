require 'spec_helper'

describe DistsController do
  include ApiClient
  
  describe "routes" do
    it { should route(:get, "/cities/1/dists").to(:action => :index, :city_id => 1) }
    it { should route(:get, "/cities/1/dists.json").to(:action => :index, :city_id => 1, :format => :json) }
    it { should route(:get, "/cities/1/dists/2").to(:action => :show, :city_id => 1, :id => 2) }
    it { should route(:get, "/cities/1/dists/2.json").to(:action => :show, :city_id => 1, :id => 2, :format => :json) }
  end
  
  describe "api interface" do
    
    before do
      @city = FactoryGirl.create :city
      @dist = @dist_enabled = FactoryGirl.create :dist_enabled, :city_id => @city.id
      @dist_name_alias_enabled = FactoryGirl.create :dist_name_alias_enabled, :dist_id => @dist_enabled.id
      @dist_name_alias_disabled = FactoryGirl.create :dist_name_alias_disabled, :dist_id => @dist_enabled.id
      @dist_disabled = FactoryGirl.create :dist_disabled, :city_id => @city.id
    end
    
    describe "get show" do
      describe "enabled dist" do
        before do
          get :show, :city_id => @city.id, :id => @dist.id, :format => :json
          @dist_hash = init_api_data
        end
        it_should_behave_like "api_data_dist"
      end
      
      it "disabled dist" do
        expect {
          get :show, :city_id => @city.id, :id => @dist_disabled.id, :format => :json
        }.to raise_error
      end
    end
    
    describe "get index" do
      before do
        get :index, :city_id => @city.id, :format => :json
        @dists = init_api_data
      end
      it { @status.should == 200 }
      describe "data format validate" do
        describe "dist" do
          before do
            @dist_hash = @dists.first
          end
          it_should_behave_like "api_data_dist"
        end
        it_should_behave_like "api_data_dists"
      end
    end
    
  end
end
