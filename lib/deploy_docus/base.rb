require 'sinatra/base'

module DeployDocus
  class Base < Sinatra::Base

    get '/' do
      "DeployDocus"
    end


    post '/:application/:environment' do
      config = DeployDocus::Config.new(params[:application])
      deployer = DeployDocus::Deployer.new(config['repository'], "keys/#{params[:application]}", config.deploy_task(params[:environment]))

      if deployer.deploy!
        "OK"
      else
        "NOT OK"
      end
    end
  end
end
