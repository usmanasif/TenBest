class AddPicturesToCompany < ActiveRecord::Migration[5.0]
  def change
    add_reference :companies, :pictures, foreign_key: true
  end
end
