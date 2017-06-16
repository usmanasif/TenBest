class AddUrlToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :url, :string
  end
end
