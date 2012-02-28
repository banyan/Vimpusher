# This file is used by Rack-based servers to start the application.
require 'rubygems'
require 'bundler'
Bundler.setup

require ::File.expand_path('../config/environment',  __FILE__)
run Vimpusher::Application
