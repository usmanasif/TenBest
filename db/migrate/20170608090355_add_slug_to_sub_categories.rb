class AddSlugToSubCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :sub_categories, :slug, :string
    add_index :sub_categories, :slug, unique: true
  end
end
