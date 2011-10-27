require 'git-ssh-wrapper'

module DeployDocus
  class Deployer
    attr_accessor :repository, :ssh_key, :deploy_task

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
      clone
      run_deploy
    end


    private
    def clone
      wrapper = GitSSHWrapper.new(:private_key_path => ssh_key)
      %x[env #{wrapper.git_ssh} git clone #{repository} #{tmp}]
    ensure
      wrapper.unlink
    end

    def run_deploy
      %x[cd #{tmp}; #{deploy_task}]
    end

    def tmp
      @tmp ||= "/tmp/#{generate_rand}"
    end

    def generate_rand
      (0...8).map{65.+(rand(25)).chr}.join
    end
  end
end
