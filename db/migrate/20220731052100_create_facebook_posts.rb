class CreateFacebookPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :facebook_posts do |t|
      t.string :name
      t.text :status
      t.timestamps
    end
  end
end
