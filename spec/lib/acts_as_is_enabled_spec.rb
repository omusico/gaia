require 'spec_helper'

shared_examples_for "acts_as_is_enabled" do
  before do
    @klass = @instance_enabled.class
  end
  
  describe "scopes" do
    it "enabled" do
      @klass.enabled.include?(@instance_enabled).should be_true
      @klass.enabled.include?(@instance_disabled).should be_false
      @instance_disabled.enable
      @klass.enabled.include?(@instance_disabled).should be_true
    end

    it "disabled" do
      @klass.disabled.include?(@instance_disabled).should be_true
      @klass.disabled.include?(@instance_enabled).should be_false
      @instance_enabled.disable
      @klass.disabled.include?(@instance_enabled).should be_true
    end
  end
  
  describe "instances" do
    it "enable" do
      @instance_disabled.enabled?.should be_false
      @instance_disabled.disabled?.should be_true
      @instance_disabled.enable.should be_true
      @instance_disabled.enabled?.should be_true
      @instance_disabled.disabled?.should be_false
    end
    
    it "disable" do
      @instance_enabled.enabled?.should be_true
      @instance_enabled.disabled?.should be_false
      @instance_enabled.disable.should be_true
      @instance_enabled.enabled?.should be_false
      @instance_enabled.disabled?.should be_true
    end
  end
end


describe "all included class" do
  
  [City, CityNameAlias, Dist].each do |klass|
    describe klass do
      before do
        @instance_enabled = FactoryGirl.create "#{klass.to_s.underscore}".to_sym
        @instance_disabled = FactoryGirl.create "#{klass.to_s.underscore}_disabled".to_sym
      end
      it_should_behave_like "acts_as_is_enabled"
    end
  end

end