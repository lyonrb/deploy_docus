require 'git-ssh-wrapper'
require 'active_model'

module DeployDocus
  class Deployer
    include ActiveModel::Validations

    attr_reader :repository, :ssh_key, :deploy_task
    attr_accessor :wrapper

    validates :repository,  :presence => {:allow_blank => false}
    validates :ssh_key,     :presence => {:allow_blank => false}
    validates :deploy_task, :presence => {:allow_blank => false}

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
      ssh_key = File.expand_path(ssh_key) if ssh_key
      @repository, @ssh_key, @deploy_task = repository, ssh_key, deploy_task
    end

    def deploy!
      if self.valid?
        GitSSHWrapper.with_wrapper(:private_key_path => ssh_key) do |w|
          @wrapper = w

          clone && run_deploy
        end
      else
        false
      end
    end


    private
    def clone
      puts "cloning #{repository}"
      clone_result = %x[#{wrapper.nil? ? '' : 'env ' + @wrapper.git_ssh} git clone #{repository} #{tmp}]
      puts clone_result
      $?.exitstatus == 0
    end

    def run_deploy
      puts "deploying : #{deploy_task} in #{tmp}"
      deploy_result = %x[cd #{tmp}; #{wrapper.nil? ? '' : 'env ' + @wrapper.git_ssh} #{deploy_task}]
      puts deploy_result
      $?.exitstatus == 0
    end

    def tmp
      @tmp ||= "/tmp/#{generate_rand}"
    end

    def generate_rand
      (0...8).map{65.+(rand(25)).chr}.join
    end
  end
end
