require 'spec_helper'

shared_examples_for "acts_as_many_name_aliases" do
  before do
    # @klass = @instance_enabled.class
  end
  
  describe "has many name_aliases" do
    it { @instance.should have_many(:name_aliases) }
  end
end


describe "all included class" do
  
  [City, Dist].each do |klass|
    describe klass do
      before do
        @instance = FactoryGirl.create klass.to_s.underscore.to_sym
      end
    
      it_should_behave_like "acts_as_many_name_aliases"
    end
  end

end