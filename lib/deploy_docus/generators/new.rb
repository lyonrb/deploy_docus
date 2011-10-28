require 'thor/group'

module DeployDocus
  module Generators
    class New < Thor::Group
      include Thor::Actions

      argument :name

      def self.source_root
        File.dirname(__FILE__)
      end

      def copy_files
        directory "templates/new", name
      end
    end
  end
end
