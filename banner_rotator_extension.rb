class BannerRotatorExtension < Radiant::Extension
  version "0.7.2"
  description "Allows addition and independent management of rotating banners on pages."
  url "https://github.com/avonderluft/radiant-banner-rotator-extension"
  
  define_routes do |map|
    map.namespace :admin do |admin|
      admin.resources :banners,  :member => { :remove => :get, :deactivate => :post } 
    end
  end

  def activate
    Page.send :include, BannerRotator::PageExtensions
    Page.send :include, BannerRotator::Tags
    admin.tabs.add "Banners", '/admin/banners', :after => "Pages", :visibility => [:admin, :developer]
    admin.pages.edit.add :extended_metadata, 'show_banner_meta'
    
    Radiant::AdminUI.class_eval do
      attr_accessor :banner
      alias_method "banners", :banner
    end
    admin.banner = load_default_banner_regions
  end
  
  def deactivate
    admin.tabs.remove "Banners"
  end
  
  def load_default_banner_regions
    returning OpenStruct.new do |banner|
      banner.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.bottom.concat %w{}
      end
    end
  end

end