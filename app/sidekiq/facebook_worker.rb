class FacebookWorker
  include Sidekiq::Worker

  def perform()
    begin
      # We pass against updated at our last created at so we get any edited post that require changes
      res = HTTParty.get("https://takehome.io/facebook?updated_at=#{FacebookPost.last ? FacebookPost.last.created_at : (DateTime.current - 1.day)}")
      parse_json = JSON.parse(res.body)
      parse_json.each do |post|
        found_post = FacebookPost.find_by(name: post["name"], status: post["status"])
        if found_post 
          found_post.update(name: post["name"], status: post["status"])
        else
          FacebookPost.create(name: post["name"], status: post["status"]) 
        end
      end
    rescue
      puts res
    end
  end
end
