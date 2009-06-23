class Admin::BannersController < Admin::ResourceController
  model_class Banner

  # TODO: Find out why the banner_placements are only updated when one is added.

  login_required
  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy, :remove_all_placements!, 
    :when => [:admin, :developer],
    :denied_url => "/admin/pages",
    :denied_message => 'You must have developer privileges to perform this action.'

  before_filter :check_cookie, :only => [:index]

  def check_cookie
    unless params[:sort]
      params[:sort] = cookies['banner_sort'] ? cookies['banner_sort'] : 'name'  
    end
    %w(active inactive).each do |view|
      if cookies['banner_view'] == view && params[:view] != view
        flash.keep
        redirect_to :view => view and return
      end
    end
  end
  
  def deactivate
    @banner = Banner.find(params[:id])
    @banner.remove_all_placements!
    flash[:notice] = "Banner \"#{@banner.name}\" has been deactivated. All Page Placements have been removed."
    redirect_to admin_banners_url
  end

end
