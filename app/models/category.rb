class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  has_many :companies
  extend FriendlyId
  friendly_id :name, use: :slugged

  # default values for keywords if created from another page without keywords
  before_save :default_values
  def default_values
    self.keywords = '' if keywords.nil?
  end
end
