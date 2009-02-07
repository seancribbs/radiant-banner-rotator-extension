class BannerRotatorExtension < Radiant::Extension
  version "1.01"
  description "Allows addition and independent management of rotating banners on pages."
  url "http://con-way.com"
  
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :banners
    end
  end
  
  def activate
    Page.send :include, Admin::BannerRotator::PageExtensions
    Page.send :include, BannerRotatorTags
    admin.tabs.add "Banners", '/admin/banners', :after => "Pages", :visibility => [:admin, :developer]
    admin.page.edit.add :extended_metadata, 'show_banner_meta'
  end
  
  def deactivate
  end
  
end