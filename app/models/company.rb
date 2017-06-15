require 'open-uri'
class Company < ApplicationRecord
  belongs_to :category
	validates :name, presence: true, uniqueness: true
	validates :category, presence: true
	validates :city, presence: true
	# validates :lat, presence: true
	# validates :lng, presence: true
	# validates :address, presence: true

	def self.required_columns
		return ["name", "category_id", "lat", "lng", "address" ]
	end

	def self.invalid(company)
		name = company["name"]
		present = Company.find_by_name( name ).present?
		return present || company["name"].blank? || company["category_id"].blank? || company["lat"].blank? || company["lng"].blank? || company["address"].blank?
	end
	
  extend FriendlyId
  friendly_id :name, use: :slugged
  #specify that the avatar is a paperclip file attachment
  #specify additional styles that you want to use in views or eslewhere
  has_attached_file :photo, url: "/assets/images/companies/:id/:style/:basename.:extension", path: ":rails_root/public/assets/images/companies/:id/:style/:basename.:extension", default_url: "/assets/images/place-image.png"
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  #pull the image from the remote url and assign it as the avatar
  def photo_from_url(url)
    self.photo = open(url)
  end
end
