class AddLikesCountToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :likes_count, :integer
  end
end
