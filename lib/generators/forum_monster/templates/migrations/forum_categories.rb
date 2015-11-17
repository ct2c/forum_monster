class CreateForumCategoriesTable < ActiveRecord::Migration
  def self.up
    create_table :forum_categories do |t|
      t.string   :title
      t.boolean  :state, :default => true
      t.integer  :position, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
