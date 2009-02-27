require File.dirname(__FILE__) + '/../spec_helper'

describe "BannerRotator::Tags" do
  dataset :pages, :banners
  
  describe "<r:banner> defaults and updating show_banner attribute" do
    if Page.columns_hash['show_banner'].default == true
      it "should show a banner if show_banner is true (default)" do
        pages(:home).should render('<r:banner>true</r:banner>').as('true')
      end
    
      it "should not show a banner if show_banner is false" do
        pages(:radius).should render('<r:banner>true</r:banner>').as('')
      end
    else
      it "should not show a banner if show_banner is false (default)" do
        pages(:home).should render('<r:banner>true</r:banner>').as('')
      end
    
      it "should show a banner if show_banner is true" do
        pages(:radius).should render('<r:banner>true</r:banner>').as('true')
      end
    end
  end

  describe "<r:banner> selection and inheritance" do
    before :each do
      Page.update_all({:show_banner => true })
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