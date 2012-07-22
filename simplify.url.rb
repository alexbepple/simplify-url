#!/usr/bin/env ruby

project_dir = File.dirname(File.realpath(__FILE__))
$LOAD_PATH.unshift File.join(project_dir, 'lib')

require 'url'

def get_clipboard
  IO.popen('pbpaste', 'r+').read
end
def write_to_clipboard text
  IO.popen('pbcopy', 'w').print text
end

write_to_clipboard Url.new(get_clipboard).simplify

puts get_clipboard
