module DeployDocus
  class Config
    attr_accessor :application

    def initialize(application)
      @application = application
    end

    def [](key)
      config[key.to_s]
    end


    private
    def config
      @config ||= YAML.load_file('config.yml')[application]
    rescue
      {}
    end
  end
end
