require 'sinatra/base'

module DeployDocus
  class Base < Sinatra::Base

    get '/' do
      "DeployDocus"
    end
  end
end
