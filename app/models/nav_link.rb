class NavLink < ApplicationRecord
  validate :active_count

  def active_count
    NavLink.where(active: true).count >= 3 ? false : true
  end
end
