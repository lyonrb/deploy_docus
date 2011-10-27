require "rubygems"
require "bundler/setup"

module DeployDocus
  autoload :Base, 'deploy_docus/base'
  autoload :Deployer, 'deploy_docus/deployer'
  autoload :Version, 'deploy_docus/version'

  def self.call(env)
    Base.call(env)
  end
end
