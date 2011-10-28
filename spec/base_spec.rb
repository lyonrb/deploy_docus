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
    before do
      DeployDocus::Config.any_instance.expects(:[]).with('repository').returns('git@github.com:evome/evome.git')
      DeployDocus::Config.any_instance.expects(:deploy_task).returns('cap staging deploy')
    end

    it "should return OK if the deploy has succeeded" do
      deployer = mock('deployer')
      DeployDocus::Deployer.expects(:new).
        with('git@github.com:evome/evome.git', 'keys/evome_rsa', 'cap staging deploy').
        returns(deployer)
      deployer.expects(:deploy!).returns(true)

      post '/evome/staging'
      assert last_response.ok?
      assert_equal last_response.body, "OK"
    end

    it "should return NOT OK if the deploy has not succeeded" do
      deployer = mock('deployer')
      DeployDocus::Deployer.expects(:new).
        with('git@github.com:evome/evome.git', 'keys/evome_rsa', 'cap staging deploy').
        returns(deployer)
      deployer.expects(:deploy!).returns(false)

      post '/evome/staging'
      assert last_response.ok?
      assert_equal last_response.body, "NOT OK"
    end
  end
end
