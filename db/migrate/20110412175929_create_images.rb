class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :url
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type
    end
    
    add_index :images, [:commentable_id, :commentable_type]
    
  end

  def self.down
    drop_table :images
  end
end
