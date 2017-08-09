class NavLink < ApplicationRecord
  validate :active_count
  has_many :children, class_name: "NavLink", foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: "NavLink"

  def active_count
    NavLink.where(parent_id: parent_id, depth: depth, active: true).count < 5
  end
end
