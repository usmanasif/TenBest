class Picture < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  default_scope { order(position: :asc) }
  has_attached_file :image
  validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }
  do_not_validate_attachment_file_type :image

  def photo_from_url(url)
    self.image = open(url)
  end

  def url
    image.url
  end
end
