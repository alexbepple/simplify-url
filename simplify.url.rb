#!/usr/bin/env ruby

project_dir = File.dirname(File.realpath(__FILE__))
$LOAD_PATH.unshift File.join(project_dir, 'lib')

require 'url'
puts UrlSimplifier.new().simplify(ARGV[0])

