class AddTitleToLinksAndChangeValueToUrl < ActiveRecord::Migration
  def up
  	change_table :links do |t|
  		t.rename :value, :url
  		t.string :title
  	end
  end
  def down
  	change_table :links do |t|
  		t.rename :url, :value
  		t.remove :title
  	end
  end
end
