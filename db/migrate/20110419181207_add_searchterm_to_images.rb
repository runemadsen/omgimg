class AddSearchtermToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :searchterm, :string
  end

  def self.down
    remove_column :images, :searchterm
  end
end
