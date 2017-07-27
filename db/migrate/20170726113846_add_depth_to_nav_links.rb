class AddDepthToNavLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :nav_links, :depth, :integer
  end
end
