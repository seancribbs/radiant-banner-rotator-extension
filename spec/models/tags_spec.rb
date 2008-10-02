require File.dirname(__FILE__) + '/../spec_helper'

describe "BannerRotator::Tags" do
  scenario :pages, :banners
  
  describe "<r:banner>" do
    it "should show a banner if show_banner is true" do
      pages(:home).should render('<r:banner>true</r:banner>').as('true')
    end
    
    it "should not show a banner if show_banner is false" do
      pages(:radius).should render('<r:banner>true</r:banner>').as('')
    end
    
    it "should select a random banner from the associated banners" do
      pages(:child_2).should render('<r:banner:name />').matching(/^Child\-2 (first|second)$/)
    end
    
    it "should inherit a banner placement from an ancestor" do
      pages(:child).should render('<r:banner:name />').as('First')
    end
  end
  
  %w{name background_image foreground_image link_url link_target image_style}.each do |att|
    describe "<r:banner:#{att}>" do
      it "should render the '#{att}' attribute of the selected banner" do
        pages(:home).should render("<r:banner:#{att} />").as(pages(:home)[att])
      end
    end
  end
end