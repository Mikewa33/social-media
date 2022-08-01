class InstagramWorker
  include Sidekiq::Worker

  def perform()
    begin
      #  We pass against updated at our last created at so we get any edited post that require changes
      res = HTTParty.get("https://takehome.io/instagram?updated_at=#{InstagramPost.last ? InstagramPost.last.updated_at : (DateTime.current - 1.day)}")
      parse_json = JSON.parse(res.body)
      parse_json.each do |post|
        found_post = InstagramPost.find_by(username: post["username"], picture: post["picture"])
        if found_post
          found_post.update(username: post["username"], picture: post["picture"])
        else
          InstagramPost.create(username: post["username"], picture: post["picture"])
        end 
      end
    rescue
      puts res
    end
  end
end
