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
      @city = Factory :city
      @dist_enabled = Factory :dist_enabled, :city_id => @city.id
      @dist_name_alias_enabled = Factory :dist_name_alias_enabled, :dist_id => @dist_enabled.id
      @dist_name_alias_disabled = Factory :dist_name_alias_disabled, :dist_id => @dist_enabled.id
      @dist_disabled = Factory :dist_disabled, :city_id => @city.id
      
    end
    
    pending "move to share example"
    
    describe "get show" do
      before do
        get :show, :city_id => @city.id, :id => @dist_enabled.id, :format => :json
        @data = init_api_data
      end
      
      it { @status.should == 200 }
      it { @data.should be_a_kind_of(Hash) }
      
      it { @data[:id].to_i.should == @dist_enabled.id }
      it { @data[:city_id].to_i.should == @city.id }
      it { @data[:city][:name].should == @city.name }
      it { @data[:city][:name_aliases].should be_a_kind_of(Array) }
      it { @data[:name_aliases].should be_a_kind_of(Array) }
      it "name aliases enabled only" do
        alias_ids = @data[:name_aliases].map{ |hash| hash[:name] }
        alias_ids.include?(@dist_name_alias_enabled.name).should be_true
        alias_ids.include?(@dist_name_alias_disabled.name).should be_false
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
        @data = init_api_data
      end
      it { @status.should == 200 }
      it { @data.should be_a_kind_of(Array) }
      describe "data format validate" do
        before do
          @dist_hash = @data.first
        end
        it { @dist_hash[:id].to_i.should == @dist_enabled.id }
        it { @data.each { |dist_hash| dist_hash[:city_id].to_i.should == @city.id } }
        it { @dist_hash[:city][:name].should == @city.name }
        it { @dist_hash[:city][:name_aliases].should be_a_kind_of(Array) }
        it { @data.should be_a_kind_of(Array) }
        it { @dist_hash[:name_aliases].should be_a_kind_of(Array) }
        it "name aliases enabled only" do
          alias_ids = @dist_hash[:name_aliases].map{ |hash| hash[:name] }
          alias_ids.include?(@dist_name_alias_enabled.name).should be_true
          alias_ids.include?(@dist_name_alias_disabled.name).should be_false
        end
        it "only enabled dists" do
          dist_ids = @data.map{ |h| h[:id].to_i }
          dist_ids.include?(@dist_enabled.id).should be_true
          dist_ids.include?(@dist_disabled.id).should be_false
        end
      end
    end
    
  end
end
