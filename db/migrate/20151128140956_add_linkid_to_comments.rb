class AddLinkidToComments < ActiveRecord::Migration
  def change
    add_column :comments, :link_id, :Integer
  end
end
