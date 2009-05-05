class ChangeBannersDefault < ActiveRecord::Migration
  def self.up
    change_column_default :pages, :show_banner, false
  end

  def self.down
    change_column_default :pages, :show_banner, true
  end
end