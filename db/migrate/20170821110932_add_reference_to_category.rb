class AddReferenceToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :pictures, index: true
  end
end
