class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  has_many :likes, dependent: :destroy

  after_create :set_embedly_attrs

  validates :url, presence: true

  scope :by_likes, -> { order('likes_count DESC') }

  def set_embedly_attrs
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])
    obj = embedly_api.oembed(url: url)
    self.embedly_title = obj.first.title
    self.embedly_description = obj.first.description

    if obj.first.thumbnail_url
      self.embedly_url = obj.first.thumbnail_url
    else
      self.embedly_url = '/images/default_thumb.jpg'
    end
    self.save
  end
end
