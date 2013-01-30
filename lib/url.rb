class Url

  require 'yaml'
  defaults = YAML.load_file('defaults.yaml')
  remove_everything_after_id = defaults['remove everything after id'].join('|')

  @simplification_patterns = [
    '(.+apple.+/app/).*(id\d+)',
    '(.+spiegel.+/).+(a-\d+.*)',
    '(.+spiegel.+/[\d,]+.html)',
    '(.+amazon.+/product/[A-Z0-9]+)',
    '(.*(?:' + remove_everything_after_id + ').+/\d+)',
    '(.+)/\?utm_source',
    '(.+)'
  ]
  class << self
    attr_reader :simplification_patterns
  end

  attr_accessor :url

  def initialize url
    @url = url
  end

  def simplify
    suitable_patterns = Url.simplification_patterns.select { |pattern| @url =~ Regexp.new(pattern) }
    regex_for_best_pattern = Regexp.new(suitable_patterns[0])
    url = regex_for_best_pattern.match(@url).captures.join()

    url = url.sub(%r{#search/[^/]+}, '#all') if url.match(/mail.google/)
    url = url.sub(%r{#[^/]+}, '#all') if url.match(/mail.google/)
    url
  end
end
