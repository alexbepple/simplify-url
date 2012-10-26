class Url
  @simplification_patterns = [
    '(.+spiegel.+/).+(a-\d+.*)',
    '(.+spiegel.+/[\d,]+.html)',
    '(.+amazon.+/product/[A-Z0-9]+)',
    '(.+(?:lifehacker|changelog).+/\d+)',
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
    regex.match(@url).captures.join()
  end
end
