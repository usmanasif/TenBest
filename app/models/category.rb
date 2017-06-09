class Category < ApplicationRecord
	has_many :sub_categories, dependent: :destroy
	validates :name, presence: true, uniqueness: true
  has_many :companies
  extend FriendlyId
  friendly_id :name, use: :slugged
end
