class Url
  @simplification_patterns = [
    '(.+spiegel.+/).+(a-\d+.*)',
    '(.+)/\?utm_source',
    '(.+/product/[A-Z0-9]+)',
    '(.+/\d+)',
  ]
  class << self
    attr_reader :simplification_patterns
  end

  attr_accessor :url

  def initialize url
    @url = url
  end

  def simplify
    Url.simplification_patterns.each do |pattern|
      match_data = @url.match Regexp.new(pattern)
      return match_data.captures.join() if match_data
    end
    @url
  end
end
