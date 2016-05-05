class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :likes, dependent: :destroy

  after_create :set_embedly_url

  validates :url, presence: true

  scope :by_likes, -> { order('likes_count DESC') }

  def set_embedly_url
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])
    obj = embedly_api.oembed(url: url)

    # self.embedly_url = obj.first.thumbnail_url
    # self.save
  end
end
