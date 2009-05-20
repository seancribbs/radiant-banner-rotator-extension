class Banner < ActiveRecord::Base
  has_many :banner_placements, :dependent => :destroy
  has_many :pages, :through => :banner_placements

  validates_presence_of :name, :background_image
  
  attr_writer :placements
  after_save :create_placements

  def placements
    @placements || banner_placements
  end

  def active?
    banner_placements.size > 0
  end

  def inactive?
    ! active?
  end
  
  def self.find_active
    @banners = []
    self.find(:all, :order => "name asc").each do |banner|
      @banners << banner if banner.active?
    end
    @banners
  end

  def self.find_inactive
    @banners = []
    self.find(:all, :order => "name asc").each do |banner|
      @banners << banner if banner.inactive?
    end
    @banners
  end

  def self.total_count
    self.find(:all).size
  end

  def self.total_active_count
    self.find_active.size
  end

  def self.total_inactive_count
    self.find_inactive.size
  end

  private
    def create_placements
      self.banner_placements.clear
      if @placements
        @placements.each do |hash|
          self.banner_placements.create(hash)
        end
      end
      @placements = nil
    end
end
