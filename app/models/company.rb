require 'open-uri'
class Company < ApplicationRecord
  belongs_to :category
  has_many :pronoun_orders
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :city, presence: true
  has_attached_file :photo, url: '/assets/images/companies/:name/:style/:basename.:extension', path: ':rails_root/public/assets/images/companies/:name/:style/:basename.:extension', default_url: '/assets/images/place-image.png'
  validates_attachment :photo, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }
  extend FriendlyId
  friendly_id :name, use: :slugged
  after_create :get_info, :create_pronoun_orders
  # after_update :get_info

  def self.required_columns
    ['name', 'category_id', 'lat', 'lng', 'address']
  end

  def self.invalid(company)
    name = company['name']
    present = Company.find_by_name(name).present?
    present || company['name'].blank? || company['category_id'].blank? || company['lat'].blank? || company['lng'].blank? || company['address'].blank?
  end

  def get_info
    info = {}
    if lat.nil? || lng.nil? || photo.nil? || address.nil? || rating.nil?
      begin
        url = "#{Rails.application.secrets[:google_place_url]}query=#{name}+#{city}&key=#{Rails.application.secrets[:google_place_key]}"
        result = RestClient.get url
        result_json = JSON.parse result
      rescue Exception => e
        info['lat'] = 37.779044
        info['lng'] = -122.418757
        info['img'] = 'place-image.png'
        info['address'] = '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102'
        info['rating'] = 2.5
      else
        if result_json['results'].nil? || result_json['results'].first.nil?
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
            photo_from_url(info['img'])
            info['img'] = photo.url
          end
        end
      end
      update(lat: info['lat'], lng: info['lng'], address: info['address'], rating: info['rating'])
    else
      info['lat'] = lat
      info['lng'] = lng
      # update info['img'] with locally generated url from paperclip
      info['img'] = photo.url
      info['address'] = address
      info['rating'] = rating
    end

    info
  end

  def photo_from_url(url)
    self.photo = open(url)
  end

  private

  def create_pronoun_orders
    puts '============================='
    puts 'creating order'
    pronoun_orders.create(state: 'order placed', description: "Please write a brief description of #{name} as one of the best #{category.name} in #{city}. They are located at #{address}. You can learn more about them by visiting their website.",
                          title: name, max_words: 125, min_words: 75, keywords: "#{category.name} in #{city}")
    pronoun_orders.create(state: 'order placed', description: "Please write a brief description of #{name} as one of the best #{category.name} in #{city}. They are located at #{address}. You can learn more about them by visiting their website.",
                          title: name, max_words: 250, min_words: 150, keywords: "#{category.name} in #{city}")
  end
end
