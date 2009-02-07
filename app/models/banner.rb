class Banner < ActiveRecord::Base
  has_many :banner_placements, :dependent => :destroy
  has_many :pages, :through => :banner_placements
  
  validates_presence_of :name, :background_image
  
  attr_writer :placements
  after_save :create_placements
  def placements
    @placements || banner_placements
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