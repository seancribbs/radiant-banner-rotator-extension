# Uncomment this if you reference any of your controllers in activate
require_dependency 'application'

class BannerRotatorExtension < Radiant::Extension
  version "1.0"
  description "Allows addition and independent management of rotating banners on pages."
  url "http://con-way.com"
  
  define_routes do |map|
    map.resources :banners, :path_prefix => '/admin'
  end
  
  def activate
    Page.send :include, BannerRotator::PageExtensions
    Page.send :include, BannerRotator::Tags
    admin.tabs.add "Banners", '/admin/banners', :after => "Pages", :visibility => [:admin, :developer]
    admin.page.edit.add :extended_metadata, 'show_banner_meta'
  end
  
  def deactivate
  end
  
end