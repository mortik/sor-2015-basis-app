class AddTagsToLinks < ActiveRecord::Migration
  def change
  	add_column :links, :tags, :string
  end
end
