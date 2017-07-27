class NavLink < ApplicationRecord
  validate :active_count
  has_many :children, class_name: "NavLink", foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: "NavLink"

  def active_count
    NavLink.where(active: true).count >= 1000 ? false : true
  end
end
