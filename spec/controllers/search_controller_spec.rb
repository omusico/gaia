# encoding: utf-8
require 'spec_helper'

describe SearchController do
  include ApiClient
  
  describe "routes" do
    it { should route(:get, "/search").to(:action => :index) }
    it { should route(:get, "/search.json").to(:action => :index, :format => :json) }
    it { should route(:get, "/search.xml").to(:action => :index, :format => :xml) }
    it { should route(:post, "/search").to(:action => :index) }
    it { should route(:post, "/search.json").to(:action => :index, :format => :json) }
    it { should route(:post, "/search.xml").to(:action => :index, :format => :xml) }
  end
  
  describe "index" do

    describe "by :zipcode" do
      before do
        @dist = Factory :dist_enabled, :zipcode => 100
        dist = Factory :dist_enabled, :zipcode => 200
      end
      it "should find by zipcode" do
        get :index, :zipcode => 100, :format => :json
        @result = init_api_data
        @result.size.should == 1
        @result.map{ |tmps| tmps["id"] }.include?(@dist.id).should be_true
      end
      
    end
    
    describe "by :text" do

      before do
        @city = Factory :city_enabled, :name => "台北"
        @city2 = Factory :city_enabled, :name => "台南"
        @city_name_alias = Factory :city_name_alias_enabled, :name => "北縣", :city_id => @city.id
        @city_name_alias2 = Factory :city_name_alias_enabled, :name => "南市", :city_id => @city2.id
        @dist = Factory :dist_enabled, :city_id => @city.id, :name => "淡水"
        @dist2 = Factory :dist_enabled, :city_id => @city2.id, :name => "中西區"
        @dist_name_alias = Factory :dist_name_alias_enabled, :name => "阿給", :dist_id => @dist.id
        @dist_name_alias2 = Factory :dist_name_alias_enabled, :name => "中區", :dist_id => @dist2.id
        @text = "這裡是台南市的中區"
        get :index, :text => @text, :format => :json
        @matches = init_api_data
        @city_ids = @matches[:cities].map{|c|c[:id]}
        @dist_ids = @matches[:dists].map{|c|c[:id]}
      end
    
      describe "data format" do
        it "hash" do
          @matches.should be_a_kind_of(Hash)
        end
        it "cities" do
          @matches[:cities].should be_a_kind_of(Array)
        end
        it "dists" do
          @matches[:dists].should be_a_kind_of(Array)
        end
        it "city columns" do
          @matches[:cities][0][:id].should be_a_kind_of(Fixnum)
          @matches[:cities][0][:name].should be_a_kind_of(String)
          @matches[:cities][0][:name_aliases].should be_a_kind_of(Array)
        end
        it "city name_aliases" do
          @matches[:cities][0][:name_aliases][0].should be_a_kind_of(String)
        end
        it "dist columns" do
          @matches[:dists][0][:id].should be_a_kind_of(Fixnum)
          @matches[:dists][0][:name].should be_a_kind_of(String)
          @matches[:dists][0][:name_aliases].should be_a_kind_of(Array)
        end
        it "dist name_aliases" do
          @matches[:dists][0][:name_aliases][0].should be_a_kind_of(String)
        end
        it "dist's city columns" do
          @matches[:dists][0][:city].should be_a_kind_of(Hash)
          @matches[:dists][0][:city][:id].should be_a_kind_of(Fixnum)
          @matches[:dists][0][:city][:name].should be_a_kind_of(String)
        end
      end
    
      describe "search matches" do
        it "should not include city id" do
          @city_ids.include?(@city.id).should be_false
        end
        it "should include city2 id" do
          @city_ids.include?(@city2.id).should be_true
        end
        it "should not include dist id" do
          @dist_ids.include?(@dist.id).should be_false
        end
        it "should include dist2 id" do
          @dist_ids.include?(@dist2.id).should be_true
        end
      end
    
      describe "disabled item should not be matched" do
        before do
          @dist2.disable
          get :index, :text => @text, :format => :json
          @matches = init_api_data
          @city_ids = @matches[:cities].map{|c|c[:id]}
          @dist_ids = @matches[:dists].map{|c|c[:id]}
        end
        it "should not include dist2 id" do
          @dist_ids.include?(@dist2.id).should be_false
        end
      end
      
    end
    
  end
end
