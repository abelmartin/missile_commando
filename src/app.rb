#!/usr/bin/env ruby

$: << File.join(File.dirname($0),"..","config")
require 'environment'
require 'debugger'

GameboxApp.run ARGV, ENV
