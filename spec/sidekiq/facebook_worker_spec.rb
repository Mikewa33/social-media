require 'rails_helper'
RSpec.describe FacebookWorker, type: :worker do
  context "it gets a response" do
    before do
      stub_request(:any, /takehome.io/).to_return(
        status: 200, 
        body: [{name: "John Doe", status: "testing is life"}].to_json, 
        headers: {"Content-Type"=> "application/json"})
    end

    it "creates one post correctly" do 
      expect{subject.perform()}.to change{FacebookPost.count}.by(1)
    end
  end

  context "it gets bad json" do
    before do
      stub_request(:any, /takehome.io/).to_return(
        status: 200, 
        body: "Locked in Facebook HQ send help", 
        headers: {"Content-Type"=> "application/json"})
    end

    it "does nothing" do 
      expect{subject.perform()}.to change{FacebookPost.count}.by(0)
    end
  end
end
