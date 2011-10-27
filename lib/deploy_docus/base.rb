require 'sinatra/base'

module DeployDocus
  class Base < Sinatra::Base

    get '/' do
      "DeployDocus"
    end


    post '/:application' do
      config = DeployDocus::Config.new(params[:application])
      deployer = DeployDocus::Deployer.new(config['repository'], config['ssh_key'], config['deploy_task'])

      if deployer.deploy!
        "OK"
      else
        "NOT OK"
      end
    end
  end
end
