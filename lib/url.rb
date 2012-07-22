class Url
  @simplification_patterns = [
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
      return Regexp.last_match(1) if @url =~ Regexp.new(pattern)
    end
  end
end
