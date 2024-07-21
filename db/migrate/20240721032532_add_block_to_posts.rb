class AddBlockToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :block, :string
  end
end
