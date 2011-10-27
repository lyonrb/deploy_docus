# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'deploy_docus/version'

Gem::Specification.new do |s|
  s.name         = "deploy_docus"
  s.version      = DeployDocus::VERSION
  s.authors      = ["Evome"]
  s.email        = "dev@evome.fr"
  s.homepage     = "https://github.com/evome/deploy_docus"
  s.summary      = "Web interface to deploy your application"
  s.description  = "Deploy your application with a POST request"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest"
  s.add_development_dependency "rack-test"
  s.add_development_dependency "mocha"

  s.add_dependency 'sinatra'
  s.add_dependency 'rake',  '>= 0.8.7'
  s.add_dependency 'git-ssh-wrapper'
end
