#!/usr/bin/env ruby

project_dir = File.dirname(File.realpath(__FILE__))
$LOAD_PATH.unshift File.join(project_dir, 'lib')


def get_clipboard
  IO.popen('pbpaste', 'r+').read
end
def write_to_clipboard text
  IO.popen('pbcopy', 'w').print text
end

require 'yaml'
defaults = YAML.load_file(File.join(project_dir, 'defaults.yaml'))

require 'url'
write_to_clipboard UrlSimplifier.new(defaults).simplify(get_clipboard)

puts get_clipboard
