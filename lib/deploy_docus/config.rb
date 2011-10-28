module DeployDocus
  class Config
    attr_accessor :application

    def initialize(application)
      @application = application
    end

    def [](key)
      config[key.to_s]
    end

    def deploy_task(environment)
      data = self['deploy_task']

      if data.is_a?(Hash)
        data[environment.to_s]
      else
        data
      end
    end


    private
    def config
      @config ||= YAML.load_file('config.yml')[application] || {}
    rescue
      {}
    end
  end
end
