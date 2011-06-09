require 'rubygems'
require 'bundler'
Bundler.setup
require 'sniff'
Sniff.init File.join(File.dirname(__FILE__), '..', '..')

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'emitter'
