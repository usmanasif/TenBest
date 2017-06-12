require 'csv'

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
end
