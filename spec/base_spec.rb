require 'spec_helper'

describe DeployDocus::Base do
  include DeployDocus::App

  describe "GET /" do
    it "should succeed" do
      get '/'
      assert last_response.ok?, "the request should succeed"
    end
  end
end
