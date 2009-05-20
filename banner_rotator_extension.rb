class BannerRotatorExtension < Radiant::Extension
  version "1.1"
  description "Allows addition and independent management of rotating banners on pages."
  url "http://github.com/avonderluft/radiant-concurrent_draft-extension/tree/master"
  
  define_routes do |map|
    # map.resources :banners, :path_prefix => '/admin'
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :banners
    end
    # if defined?(ConcurrentDraft)
    #   map.banner_schedule_draft_promotion 'admin/banners/schedule_draft_promotion/:id',
    #     :controller => 'admin/banners', :action => 'schedule_draft_promotion'
    # end
  end
  
  def activate
    Page.send :include, BannerRotator::PageExtensions
    Page.send :include, BannerRotator::Tags
    admin.tabs.add "Banners", '/admin/banners', :after => "Pages", :visibility => [:admin, :developer]
    admin.pages.edit.add :extended_metadata, 'show_banner_meta'
    # if defined?(ConcurrentDraft)
    #   Banner.send :include, ConcurrentDraft::ModelExtensions
    #   Admin::BannersController.send :include, ConcurrentDraft::AdminControllerExtensions
    #   Admin::BannersController.send :helper, ConcurrentDraft::HelperExtensions
    # end
  end
  
end