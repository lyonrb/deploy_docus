require 'git-ssh-wrapper'

module DeployDocus
  class Deployer
    attr_reader :repository, :ssh_key, :deploy_task
    attr_accessor :wrapper

    #
    # Manages cloning and deploying the repository
    # This class is agnostic of any web interface and can be used as a library
    #
    # DeployDocus::Deployer("git@github.com:evome/evome.git", "~/.ssh/evome_key", "cap staging deploy")
    #
    # It will clone the repository in a random directory located in /tmp.
    # And execute the deploy_task on it.
    #
    def initialize(repository, ssh_key, deploy_task)
      @repository, @ssh_key, @deploy_task = repository, ssh_key, deploy_task
    end

    def deploy!
      GitSSHWrapper.with_wrapper(:private_key_path => ssh_key) do |w|
        wrapper = w

        clone
        run_deploy
      end
    end


    private
    def clone
      puts "cloning #{repository}"
      %x[#{@wrapper ? 'env ' + @wrapper.git_ssh : ''} git clone #{repository} #{tmp}]
    end

    def run_deploy
      puts "deploying : #{deploy_task}"
      %x[#{@wrapper ? 'env ' + @wrapper.git_ssh : ''} cd #{tmp}; #{deploy_task}]
    end

    def tmp
      @tmp ||= "/tmp/#{generate_rand}"
    end

    def generate_rand
      (0...8).map{65.+(rand(25)).chr}.join
    end
  end
end
