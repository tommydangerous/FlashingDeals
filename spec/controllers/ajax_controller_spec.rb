require 'spec_helper'

describe AjaxController do

  describe "GET 'friend_requests'" do
    it "returns http success" do
      get 'friend_requests'
      response.should be_success
    end
  end

  describe "GET 'message_count'" do
    it "returns http success" do
      get 'message_count'
      response.should be_success
    end
  end

end
