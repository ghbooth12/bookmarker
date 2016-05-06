class AddColumnsToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :embedly_title, :string
    add_column :bookmarks, :embedly_description, :text
  end
end
