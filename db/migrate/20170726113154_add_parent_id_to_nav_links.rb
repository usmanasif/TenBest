class AddParentIdToNavLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :nav_links, :parent_id, :integer
  end
end
