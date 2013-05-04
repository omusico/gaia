require 'spec_helper'

describe CitiesController do
  describe "#select" do
    it "blank selected values" do
      get "/select.js", :selected_city_id => "", :selected_dist_id => ""
      response.should be_success
    end
  end
end