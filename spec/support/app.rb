require 'rack/test'

module DeployDocus::App

  def self.included(klass)
    klass.class_eval do
      include Rack::Test::Methods

      let(:app) { DeployDocus }

    end
  end
end
