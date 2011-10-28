require 'spec_helper'

describe DeployDocus::Base do
  include DeployDocus::App

  describe "GET /" do
    it "should succeed" do
      get '/'
      assert last_response.ok?, "the request should succeed"
    end
  end

  describe "POST /application" do
    describe "with token" do
      before do
        DeployDocus::Config.any_instance.expects(:[]).with('repository').returns('git@github.com:evome/evome.git')
        DeployDocus::Config.any_instance.expects(:deploy_task).returns('cap staging deploy')
        DeployDocus::Config.any_instance.expects(:[]).with('token').returns('azertyuiop')
      end

      it "should return OK if the deploy has succeeded" do
        deployer = mock('deployer')
        DeployDocus::Deployer.expects(:new).
          with('git@github.com:evome/evome.git', 'keys/evome_rsa', 'cap staging deploy').
          returns(deployer)
        deployer.expects(:deploy!).returns(true)

        post '/evome/staging', :token => 'azertyuiop'
        assert last_response.ok?
        assert_equal last_response.body, "{\"status\":\"OK\"}"
      end

      it "should return NOT OK if the deploy has not succeeded" do
        deployer = mock('deployer')
        DeployDocus::Deployer.expects(:new).
          with('git@github.com:evome/evome.git', 'keys/evome_rsa', 'cap staging deploy').
          returns(deployer)
        deployer.expects(:deploy!).returns(false)
        deployer.expects(:errors).returns({})

        post '/evome/staging', :token => 'azertyuiop'
        assert last_response.ok?
        assert_equal last_response.body, "{\"status\":\"NOT OK\",\"error\":{}}"
      end
    end

    describe "without token" do
      it "should return a 401 if there is no token" do
        post '/evome/staging'
        assert_equal last_response.status, 401
      end

      it "should return a 401 if the token is invalid" do
        post '/evome/staging', :token => 'chuck_norris'
        assert_equal last_response.status, 401
      end
    end
  end
end
