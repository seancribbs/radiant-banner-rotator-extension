class CreateBanners < ActiveRecord::Migration
  def self.up
    create_table :banners do |t|
      t.string :name
      t.string :background_image
      t.string :foreground_image
      t.string :link_url
      t.string :link_target
      t.string :image_style
      
      t.timestamps
    end
    
    create_table :banner_placements do |t|
      t.integer :banner_id
      t.integer :page_id
      t.integer :weight, :default => 1, :nil => false
      
      t.timestamps
    end
    add_index :banner_placements, [:page_id, :banner_id], :name =>  'page_id_on_banner_id'
    
    add_column :pages, :show_banner, :boolean, :default => true
  end

  def self.down
    drop_table :banners
    drop_table :banner_placements
    remove_column :pages, :show_banner
  end
end
