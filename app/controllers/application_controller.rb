class ApplicationController < ActionController::Base

  def index
    render json: { twitter: TwitterPost.select("id, username, tweet").all, facebook: FacebookPost.select("id, name, status").all, instagram: InstagramPost.select("id, username, picture").all }
  end
end
