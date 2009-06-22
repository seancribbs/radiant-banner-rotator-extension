class BannerRotatorExtension < Radiant::Extension
  version "1.1"
  description "Allows addition and independent management of rotating banners on pages."
  url "http://github.com/avonderluft/radiant-concurrent_draft-extension/tree/master"
  
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
  end
  
end