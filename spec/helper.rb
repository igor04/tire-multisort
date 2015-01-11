require 'rubygems'
require 'bundler'
require "codeclimate-test-reporter"

ENV['CODECLIMATE_REPO_TOKEN'] = '9db5a2e5847018b781c2d42d12ea9b05c4662b2cfad232b356731700da5cc418'
CodeClimate::TestReporter.start
require "#{File.dirname(__FILE__)}/../lib/tire-multisort"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
