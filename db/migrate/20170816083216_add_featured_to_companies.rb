class AddFeaturedToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :featured, :boolean
  end
end
