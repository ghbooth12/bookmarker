class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :likes, dependent: :destroy

  validates :url, presence: true

  # after_create :set_embedly_url
  #
  #
  # def set_embedly_url
  #   # call embedly here
  #   # set the embedly_url value for the bookmark and save
  # end
end
