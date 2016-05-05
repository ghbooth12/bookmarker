class ChangeBookmarksEmbedlyUrl < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :bookmarks do |t|
        dir.up   { t.change :embedly_url, :string }
        dir.down { t.change :embedly_url, :integer }
      end
    end
  end
end
