require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::BannersHelper do
  dataset :home_page
  
  it "should create options for the placements select box from existing pages" do
    helper.pages_for_select.should == [["Home", page_id(:home)]]
  end
end
