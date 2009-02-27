class BannerRotatorExtension < Radiant::Extension
  version "1.0.2"
  description "Allows addition and independent management of rotating banners on pages."
  url "http://github.com/avonderluft/radiant-concurrent_draft-extension/tree/master"
  
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :banners
    end
  end
  
  def activate
    Page.send :include, BannerRotator::PageExtensions
    Page.send :include, BannerRotator::Tags
    admin.tabs.add "Banners", '/admin/banners', :after => "Pages", :visibility => [:admin, :developer]
    admin.pages.edit.add :extended_metadata, 'show_banner_meta'
  end
  
end