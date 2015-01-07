require 'rubygems'
require 'bundler'
require "#{File.dirname(__FILE__)}/../lib/tire-multisort"

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
