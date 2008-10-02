require_dependency 'application'
class BannersController < ApplicationController  
  make_resourceful do
    actions :all
  
    response_for :create, :update do
      flash[:notice] = "The banner was saved."
      redirect_to banners_path
    end
  end
  
  def current_objects
    @current_objects ||= current_model.find(:all, :order => "name asc")
  end
  
  login_required
  only_allow_access_to :index, :show, :new, :create, :edit, :update, :destroy, 
      :when => [:admin, :developer],
      :denied_url => "/admin/pages",
      :denied_message => 'You must have developer privileges to perform this action.'

end
