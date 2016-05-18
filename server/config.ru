#\ -s puma
require 'bundler/setup'

root = ::File.dirname(__FILE__)
require ::File.join(root, 'config')

run start_app
