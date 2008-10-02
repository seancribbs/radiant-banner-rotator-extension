require File.dirname(__FILE__) + '/../spec_helper'

describe Banner do
  before(:each) do
    @banner = Banner.new :name => "Test Banner", :background_image => "image.png"
  end

  it "should require a name" do
    @banner.name = nil
    @banner.should_not be_valid
    @banner.should have(1).error_on(:name)
  end

  it "should require a background image" do
    @banner.background_image = nil
    @banner.should_not be_valid
    @banner.should have(1).error_on(:background_image)
  end

  it "should be valid with required parameters" do
    @banner.should be_valid
  end
  
  it "should save associated page placements" do
    @banner.placements = [{'page_id' => '1', 'weight' => '10'}, {'page_id' => '2', 'weight' => '5'}]
    @banner.save.should be_true
    @banner.should have(2).banner_placements
    @banner.placements.should be_all{|p| p.valid? }
  end
end
