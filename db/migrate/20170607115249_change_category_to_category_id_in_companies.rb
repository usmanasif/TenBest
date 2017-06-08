class ChangeCategoryToCategoryIdInCompanies < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :companies, :category, :category_id
    rename_column :companies, :subcategory, :subcategory_id
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
