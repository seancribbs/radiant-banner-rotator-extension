class Admin::BannersController < Admin::ResourceController
  model_class Banner

  # TODO: Find out why the banner_placements are only updated when one is added.
 
#  login_required
#  only_allow_access_to :index, :show, :new, :create, :edit, :update, :destroy,
#      :when => [:admin, :developer],
#      :denied_url => "/admin/pages",
#      :denied_message => 'You must have developer privileges to perform this action.'

end
