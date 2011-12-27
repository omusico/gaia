require 'spec_helper'

describe CitiesController do
  include ApiClient
  
  describe "routes" do
    it { should route(:get, "/cities").to(:action => :index) }
    it { should route(:get, "/cities.json").to(:action => :index, :format => :json) }
    it { should route(:get, "/cities/1").to(:action => :show,:id => 1) }
    it { should route(:get, "/cities/2.json").to(:action => :show, :id => 2, :format => :json) }
  end
  
  describe "api interface" do
    before do
      @city = @city_enabled = Factory(:city_enabled)
      @city_disabled = Factory :city_disabled
      @city_name_alias_enabled = Factory :city_name_alias_enabled, :city_id => @city_enabled.id
      @city_name_alias_disabled = Factory :city_name_alias_disabled, :city_id => @city_enabled.id
      @dist = @dist_enabled = Factory(:dist_enabled, :city_id => @city.id)
      @dist_name_alias_enabled = Factory :dist_name_alias_enabled, :dist_id => @dist_enabled.id
      @dist_name_alias_disabled = Factory :dist_name_alias_disabled, :dist_id => @dist_enabled.id
      @dist_disabled = Factory :dist_disabled, :city_id => @city.id
    end
    describe "get index" do
      before do
        get :index, :format => :json
        @cities = init_api_data
      end
      it_should_behave_like "api_data_cities"
    end
    describe "get show" do
      describe "enabled" do
        before do
          get :show, :id => @city.id, :format => :json
          @city_hash = init_api_data
        end
        it_should_behave_like "api_data_city"
      end
      it "disabled" do
        expect {
          get :show, :id => @city_disabled.id, :format => :json
        }.to raise_error
      end
    end
  end
end
