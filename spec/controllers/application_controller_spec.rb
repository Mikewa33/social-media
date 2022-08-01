# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe "#create" do
    context "when no data is present" do
      it "returns empty arrays" do
        get :index

        expect(response.body).to eql({ twitter: [], facebook: [], instagram: []}.to_json)
      end
    end

    context "when data is present" do
      before do
        TwitterPost.create(username: 'JohnDoe01', tweet: 'FooBar')
        FacebookPost.create(name: 'JohnDoe02', status: 'hello world')
      end

      it "returns json of the data" do
        get :index

        expect(response.body).to eql({ 
          twitter: [{id: TwitterPost.last.id, username: 'JohnDoe01', tweet: 'FooBar'}], 
          facebook: [{id: FacebookPost.last.id, name: 'JohnDoe02', status: 'hello world'}], 
          instagram: []}.to_json)
      end
    end
  end
end