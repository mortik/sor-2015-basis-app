class AddUrlToComments < ActiveRecord::Migration
  def up
  	change_table :comments do |t|
  		t.string :url
  	end
  end
  def down
  	change_table :comments do |t|
  		t.remove :url
  	end
  end
end
