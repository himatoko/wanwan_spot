class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :shop_name
      t.text :recommend_point
      t.text :advice
      t.string :prefecture
      t.string :address
      t.timestamps
    end
  end
end
