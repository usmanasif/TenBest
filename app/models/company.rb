require 'open-uri'
class Company < ApplicationRecord
  belongs_to :category
	validates :name, presence: true, uniqueness: true
	validates :category, presence: true
	validates :city, presence: true
  extend FriendlyId
  friendly_id :name, use: :slugged
  #specify that the avatar is a paperclip file attachment
  #specify additional styles that you want to use in views or eslewhere
  has_attached_file :photo, :url  => "/assets/images/companies/:id/:style/:basename.:extension", :path => ":rails_root/public/assets/images/companies/:id/:style/:basename.:extension"
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  #pull the image from the remote url and assign it as the avatar
  def photo_from_url(url)
    self.photo = open(url)
  end
end
