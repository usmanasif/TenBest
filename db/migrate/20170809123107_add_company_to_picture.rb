class AddCompanyToPicture < ActiveRecord::Migration[5.0]
  def change
    add_reference :pictures, :company, foreign_key: true
  end
end
