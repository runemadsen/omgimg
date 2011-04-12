class CreateDiscussions < ActiveRecord::Migration
  def self.up
    create_table :discussions do |t|
      t.date :date
    end
  end

  def self.down
    drop_table :discussions
  end
end
