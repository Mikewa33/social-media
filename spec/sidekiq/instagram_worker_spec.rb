require 'rails_helper'
RSpec.describe InstagramWorker, type: :worker do
  context "it gets a response" do
    before do
      stub_request(:any, /takehome.io/).to_return(
        status: 200, 
        body: [{username: "Foodies", tweet: "coding soup"}].to_json, 
        headers: {"Content-Type"=> "application/json"})
    end

    it "creates one post correctly" do 
      expect{subject.perform()}.to change{InstagramPost.count}.by(1)
    end
  end

  context "it gets bad json" do
    before do
      stub_request(:any, /takehome.io/).to_return(
        status: 200, 
        body: "Another food pic", 
        headers: {"Content-Type"=> "application/json"})
    end

    it "does nothing" do 
      expect{subject.perform()}.to change{InstagramPost.count}.by(0)
    end
  end
end
