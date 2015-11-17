class CreateCategoriesTable < ActiveRecord::Migration
  def self.up
    if !ActiveRecord::Base.connection.table_exists?("categories")
      create_table :categories do |t|
        t.string   :title
        t.boolean  :state, :default => true
        t.integer  :position, :default => 0

        t.timestamps
      end
    else
      add_column :categories, :title, :string
      add_column :categories, :state, :boolean, default: true
      add_column :categories, :position, :integer, default: 0
    end
  end

  def self.down
    drop_table :categories
  end
end
