class CreateInstagramPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :instagram_posts do |t|
      t.string :username
      t.string :picture
      t.timestamps
    end
  end
end
