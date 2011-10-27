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
end
