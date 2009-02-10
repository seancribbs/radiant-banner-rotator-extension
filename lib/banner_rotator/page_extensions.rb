module BannerRotator
  module PageExtensions
    def self.included(base)
      base.class_eval do
        has_many :banner_placements, :dependent => :delete_all
        has_many :banners, :through => :banner_placements
        
        alias_method_chain :banner_placements, :inheritance
      end
    end
    
    def banner_placements_with_inheritance
      if banner_placements_without_inheritance.empty? && parent
        parent.banner_placements
      else
        banner_placements_without_inheritance
      end
    end
    
    def select_banner
      banners_with_weighting = banner_placements.map do |p|
        [p.banner] * p.weight
      end.flatten
      banners_with_weighting[rand(banners_with_weighting.size)]
    end
  end
end