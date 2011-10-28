require 'spec_helper'

describe DeployDocus::Deployer do
  before do
    @deployer = DeployDocus::Deployer.new("git://github.com/evome/deploy_docus.git", "~/.ssh/id_rsa", "ls -l")
  end


  describe "initialize" do
    it "should define the repository" do
      assert_equal "git://github.com/evome/deploy_docus.git", @deployer.repository
    end

    it "should define the ssh key path" do
      assert_equal File.expand_path("~/.ssh/id_rsa"), @deployer.ssh_key
    end

    it "should define the deploy task" do
      assert_equal "ls -l", @deployer.deploy_task
    end
  end

  describe "validations" do
    before do
      @deployer = DeployDocus::Deployer.new(nil, nil, nil)
      assert !@deployer.valid?
    end

    it "should require a repository" do
      assert_equal @deployer.errors[:repository], ['can\'t be blank']
    end

    it "should require a ssh_key" do
      assert_equal @deployer.errors[:ssh_key], ['can\'t be blank']
    end

    it "should require a deploy_task" do
      assert_equal @deployer.errors[:deploy_task], ['can\'t be blank']
    end

  end

  describe "deploy!" do
    it "should call clone and run_deploy" do
      @deployer.expects(:clone).returns(true)
      @deployer.expects(:run_deploy).returns(true)

      assert @deployer.deploy!
    end

    it "should return false if the validations fail" do
      @deployer.expects(:valid?).returns(false)
      @deployer.expects(:clone).never
      @deployer.expects(:run_deploy).never

      assert !@deployer.deploy!
    end
  end

  describe "clone" do
    it "should clone the repository" do
      @deployer.expects(:`).with(regexp_matches(/^ git clone git:\/\/github.com\/evome\/deploy_docus\.git .*$/)).once
      @deployer.send(:clone)
    end
  end

  describe "run_deploy" do
    it "should run the deploy task" do
      @deployer.expects(:`).with(regexp_matches(/^ cd .*; ls -l$/)).once
      @deployer.send(:run_deploy)
    end
  end
end
