class AddKeywordsToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :keywords, :string
  end
end
