class RemoveColumnsFromCompany < ActiveRecord::Migration[5.0]
  def change
    remove_column :companies, :photo, :string
    remove_column :companies, :photo_file_name, :string
    remove_column :companies, :photo_content_type, :string
    remove_column :companies, :photo_file_size, :integer
    remove_column :companies, :photo_updated_at, :datetime
  end
end
