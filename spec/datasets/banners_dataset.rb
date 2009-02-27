class BannersDataset < Dataset::Base
  uses :pages
  def load
    create_model Banner, :first, :name => "First", :background_image => "test.jpg", :foreground_image => 'front.jpg', :link_target => "_blank", :link_url => "/en/", :image_style => "text-align:right"
    create_model BannerPlacement, :first, :page_id => page_id(:home), :banner_id => banner_id(:first), :weight => 5
    Page.update_all({:show_banner => !  Page.columns_hash['show_banner'].default }, {:id => page_id(:radius)})
    create_model Banner, :child_2_1, :name => "Child-2 first", :background_image => "test.jpg"
    create_model BannerPlacement, :child_2_1, :page_id => page_id(:child_2), :banner_id => banner_id(:child_2_1), :weight => 1
    create_model Banner, :child_2_2, :name => "Child-2 second", :background_image => "test.jpg"
    create_model BannerPlacement, :child_2_2, :page_id => page_id(:child_2), :banner_id => banner_id(:child_2_2), :weight => 1    
  end
end