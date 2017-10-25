require './server'
require 'sinatra/activerecord/rake'
require 'rubygems'
require 'rspec/core/rake_task'
require 'dotenv/load'
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end
