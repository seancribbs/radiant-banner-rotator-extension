class BannerPlacement < ActiveRecord::Base
  belongs_to :page
  belongs_to :banner
  validates_presence_of :page_id, :banner_id, :weight
  validates_inclusion_of :weight, :in => 1..10, :allow_nil => true
  validates_uniqueness_of :page_id, :scope => :banner_id
end