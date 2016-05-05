class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark, counter_cache: true
end
