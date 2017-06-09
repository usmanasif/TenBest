class Company < ApplicationRecord
  belongs_to :category
	validates :name, presence: true, uniqueness: true
	validates :category, presence: true
	validates :city, presence: true
  extend FriendlyId
  friendly_id :name, use: :slugged
end
