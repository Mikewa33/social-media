class TwitterWorker
  include Sidekiq::Worker

  def perform()
    begin
      #  We pass against updated at our last created at so we get any edited post that require changes
      res = HTTParty.get("https://takehome.io/twitter?updated_at=#{TwitterPost.last ? TwitterPost.last.created_at : (DateTime.current - 1.day)}")
      parse_json = JSON.parse(res.body)
      parse_json.each do |post|
        found_post = TwitterPost.find_by(username: post["username"], tweet: post["tweet"])
        if found_post
          found_post.update(username: post["username"], tweet: post["tweet"])
        else
          TwitterPost.create(username: post["username"], tweet: post["tweet"]) 
        end
      end
    rescue
      puts res
    end
  end
end
