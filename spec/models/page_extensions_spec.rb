require File.dirname(__FILE__) + '/../spec_helper'

describe "BannerRotator::PageExtensions" do
  dataset :pages, :banners
  
  it "should have some banner and banner placements" do
    pages(:home).should respond_to(:banners)
    pages(:home).should respond_to(:banner_placements)
    pages(:home).should have(1).banners
  end
  
  it "should select a banner" do
    pages(:home).select_banner.should == banners(:first)
  end
  
  it "should inherit banners from its ancestors" do
    pages(:article).banner_placements.should == pages(:home).banner_placements
    pages(:article).select_banner.should == banners(:first)
  end
  
  it "should not delete its parent's banner placements when destroyed" do
    lambda { pages(:radius).destroy }.should_not change(BannerPlacement, :count)
  end
end