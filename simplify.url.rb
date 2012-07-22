#!/usr/bin/env ruby

project_dir = File.dirname(File.realpath(__FILE__))
$LOAD_PATH.unshift File.join(project_dir, 'lib')

require 'url'

clipboard = IO.popen('pbpaste', 'r+').read
simplified_url = Url.new(clipboard).simplify
p simplified_url
IO.popen('pbcopy', 'w').print simplified_url
