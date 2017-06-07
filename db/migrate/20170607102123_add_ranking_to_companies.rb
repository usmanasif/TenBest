class AddRankingToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :rating, :float
  end
end
