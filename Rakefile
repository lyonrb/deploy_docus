# encoding: UTF-8

require 'rake'
require 'rake/testtask'

require 'deploy_docus'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "spec"
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
  t.warning = true
end
