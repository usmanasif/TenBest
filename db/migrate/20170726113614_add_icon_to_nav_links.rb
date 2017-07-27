class AddIconToNavLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :nav_links, :icon, :string
  end
end
