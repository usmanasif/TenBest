class AddPolymorphicToPicture < ActiveRecord::Migration[5.0]
  def self.up
    remove_reference(:pictures, :company, index: true)
    change_table :pictures do |t|
      t.references :imageable, polymorphic: true, index: true
    end
  end

  def self.down
    change_table :pictures do |t|
      t.references :company
    end
    remove_reference(:categories, :imageable, polymorphic: true, index: true)
  end
end
