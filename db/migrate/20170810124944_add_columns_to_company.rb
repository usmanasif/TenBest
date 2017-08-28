class AddColumnsToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :contact, :string
    add_column :companies, :settings, :jsonb, default: {}
  end
end
