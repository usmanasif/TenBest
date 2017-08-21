class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  has_many :companies
  has_many :pictures, as: :imageable, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged

  # default values for keywords if created from another page without keywords
  before_save :default_values
  def default_values
    self.keywords = '' if keywords.nil?
  end

  def image
    if pictures.count != 0
      pictures.first
    else
      Picture.new
    end
  end

  def images
    pictures
  end

  def images=(files)
    pictures.clear
    files.try(:each) do |file|
      pictures.new(name: name, position: images.count + 1, image: file)
    end
  end
end
