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
      bookmark.likes_count = bookmark.likes.count
      bookmark.save!
    end
  end
end
