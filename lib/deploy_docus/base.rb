require 'sinatra/base'
require 'json'

module DeployDocus
  class Base < Sinatra::Base

    get '/' do
      "DeployDocus"
    end


    post '/:application/:environment' do
      config = DeployDocus::Config.new(params[:application])

      if params[:token] && config['token'] == params[:token]
        deployer = DeployDocus::Deployer.new(config['repository'], "keys/#{params[:application]}_rsa", config.deploy_task(params[:environment]))

        content_type :json
        if deployer.deploy!
          {:status => "OK"}.to_json
        else
          {:status => "NOT OK", :error => deployer.errors}.to_json
        end
      else
        throw :halt, [401, 'Authorization Required']
      end
    end
  end
end
