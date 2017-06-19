class CreatePronounOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :pronoun_orders do |t|
      t.string :title
      t.integer :max_words
      t.integer :min_words
      t.text :submitted_text
      t.string :keywords
      t.string :state
      t.string :description
      t.integer :company_id
      t.integer :pronun_id

      t.timestamps
    end
  end
end
