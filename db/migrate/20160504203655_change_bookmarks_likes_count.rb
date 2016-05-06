class ChangeBookmarksLikesCount < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :bookmarks do |t|
        dir.up   { t.change :likes_count, :integer, default: 0 }
        dir.down { t.change :likes_count, :integer, default: nil }
      end
    end

    Bookmark.reset_column_information
    Bookmark.all.each do |bookmark|
      bookmark.likes_count = bookmark.likes.count || 0
      bookmark.save!
    end

    # catch the case where rails is thinking the bookmark didn't need updating
    bookmarks = Bookmark.where(likes_count: nil)
    bookmarks.update_all(likes_count: 0)
  end
end
