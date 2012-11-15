class Url
  @simplification_patterns = [
    '(.+apple.+/app/).*(id\d+)',
    '(.+spiegel.+/).+(a-\d+.*)',
    '(.+spiegel.+/[\d,]+.html)',
    '(.+amazon.+/product/[A-Z0-9]+)',
    '(.+(?:lifehacker|changelog|gizmodo).+/\d+)',
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
    suitable = Url.simplification_patterns.select { |pattern| @url =~ Regexp.new(pattern) }
    regex = Regexp.new(suitable[0])
    url = regex.match(@url).captures.join()

    url = url.sub(%r{#search/[^/]+}, '#all') if url.match(/mail.google/)
    url = url.sub(%r{#[^/]+}, '#all') if url.match(/mail.google/)
    url
  end
end
