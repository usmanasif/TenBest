class RemoveFeaturedFromCompanies < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :featured, :boolean
  end
end
