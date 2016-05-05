class AddEmbedlyUrlToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :embedly_url, :integer
  end
end
