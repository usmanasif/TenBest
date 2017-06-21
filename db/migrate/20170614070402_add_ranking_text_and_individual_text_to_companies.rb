class AddRankingTextAndIndividualTextToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :intro, :text
    add_column :companies, :description, :text
  end
end
