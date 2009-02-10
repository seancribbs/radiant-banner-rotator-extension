require File.dirname(__FILE__) + '/../spec_helper'

describe BannerPlacement do
  dataset :banners
  
  before(:each) do
    @placement = BannerPlacement.new :page_id => 5, :banner_id => 5, :weight => 10
  end
  
  it "should require a page" do
    @placement.page_id = nil
    @placement.should_not be_valid
    @placement.should have(1).error_on(:page_id)
  end
  
  it "should require a banner" do
    @placement.banner_id = nil
    @placement.should_not be_valid
    @placement.should have(1).error_on(:banner_id)
  end
  
  it "should require a weight" do
    @placement.weight = nil
    @placement.should_not be_valid
    @placement.should have(1).error_on(:weight)
  end
  
  it "should require weight to be a number" do
    @placement.weight = 'foo'
    @placement.should_not be_valid
    @placement.should have(1).error_on(:weight)
  end
  
  it "should be unique to a given page and banner" do
    @placement.page_id = page_id(:home)
    @placement.banner_id = banner_id(:first)
    @placement.should_not be_valid
  end
  
  it "should be valid with required parameters" do
    @placement.should be_valid
  end
end