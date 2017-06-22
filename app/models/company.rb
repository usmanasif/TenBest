require 'open-uri'
class Company < ApplicationRecord
  belongs_to :category
  has_many :pronoun_orders
	validates :name, presence: true, uniqueness: true
	validates :category, presence: true
	validates :city, presence: true
	has_attached_file :photo, url: "/assets/images/companies/:name/:style/:basename.:extension", path: ":rails_root/public/assets/images/companies/:name/:style/:basename.:extension", default_url: "/assets/images/place-image.png"
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

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
  after_create :get_info,:create_pronoun_orders
  # after_update :get_info

  def get_info
    info = {}
    if self.lat.nil? or self.lng.nil? or self.photo.nil? or self.address.nil? or self.rating.nil?
      begin
        url = "#{Rails.application.secrets[:google_place_url]}query=#{self.name}+#{self.city}&key=#{Rails.application.secrets[:google_place_key]}"
        result = RestClient.get url
        result_json = JSON.parse result
      rescue Exception => e
        info['lat'] = 37.779044
        info['lng'] = -122.418757
        info['img'] = 'place-image.png'
        info['address'] = '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102'
        info['rating'] = 2.5
      else
        if result_json['results'].nil? or result_json['results'].first.nil?
          info['lat'] = 37.779044
          info['lng'] = -122.418757
          info['img'] = 'place-image.png'
          info['address'] = '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102'
          info['rating'] = 2.5
        else
          info['lat'] = result_json['results'].first['geometry']['location']['lat']
          info['lng'] = result_json['results'].first['geometry']['location']['lng']
          info['address'] = result_json['results'].first['formatted_address']
          info['rating'] = result_json['results'].first['rating']
          if result_json['results'].first['photos'].nil?
            info['img'] = 'place-image.png'
          else
            photo_reference = result_json['results'].first['photos'].first['photo_reference']
            info['img'] = "#{Rails.application.secrets[:google_photo_url]}maxheight=400&photoreference=#{photo_reference}&key=#{Rails.application.secrets[:google_photo_key]}"
          end
        end
      end
      self.update( :lat => info['lat'], :lng => info['lng'], :address => info['address'], :rating => info['rating'] )
    else
      info['lat'] = self.lat
      info['lng'] = self.lng
      info['img'] = self.photo
      info['address'] = self.address
      info['rating'] = self.rating
    end

    return info
  end
  def photo_from_url(url)
    self.photo = open(url)
  end

  private

  def create_pronoun_orders
    puts "============================="
    puts "creating order"
    self.pronoun_orders.create(state: "order placed", description:"Please write a brief description of #{self.name} as one of the best #{self.category.name} in #{self.city}. They are located at #{self.address}. You can learn more about them by visiting their website.",
    title: self.name, max_words: 125, min_words: 75, keywords: "#{self.category.name} in #{self.city}")
    self.pronoun_orders.create(state: "order placed", description:"Please write a brief description of #{self.name} as one of the best #{self.category.name} in #{self.city}. They are located at #{self.address}. You can learn more about them by visiting their website.",
    title: self.name, max_words: 250, min_words: 150, keywords: "#{self.category.name} in #{self.city}")
  end
end
