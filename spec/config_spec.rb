require 'spec_helper'

describe DeployDocus::Config do
  before do
    @config = DeployDocus::Config.new('evome')
  end

  describe "initialize" do
    it "should set the application" do
      assert_equal 'evome', @config.application
    end
  end

  describe '[]' do
    before do
      @config.instance_eval do
        @config = {'repository' => 'git@github.com:evome/evome.git'}
      end
    end

    it "should return the config parameter" do
      assert_equal 'git@github.com:evome/evome.git', @config['repository']
    end

    it "should work with a symbol" do
      assert_equal 'git@github.com:evome/evome.git', @config[:repository]
    end
  end

  describe "deploy_task" do
    it "should return the deploy_task as a string" do
      @config.instance_eval do
        @config = {}
        @config['deploy_task'] = "cap deploy"
      end

      assert_equal @config.deploy_task('staging'), "cap deploy"
      assert_equal @config.deploy_task('production'), "cap deploy"
    end

    it "should return the deploy_task with environment as a hash" do
      @config.instance_eval do
        @config = {}
        @config['deploy_task'] = {
          'staging' => 'cap staging deploy',
          'production' => 'cap production deploy'
        }
      end

      assert_equal @config.deploy_task('staging'), "cap staging deploy"
      assert_equal @config.deploy_task('production'), "cap production deploy"
    end
  end
end
