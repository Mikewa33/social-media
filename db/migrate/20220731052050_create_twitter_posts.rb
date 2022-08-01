class CreateTwitterPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :twitter_posts do |t|
      t.string :username
      t.text :tweet
      t.timestamps
    end
  end
end
