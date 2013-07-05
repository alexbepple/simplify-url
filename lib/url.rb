class UrlSimplifier

  def initialize
    @substitution_patterns = [
      [/mail.google/, %r{#(search|label)/[^/]+}, '#all'],
      [/mail.google/, %r{#[^/]+},                '#all'],
      [/amazon/, %r{gp/product}, 'dp'],
    ]
    @simplification_patterns = [
      '(.+apple.+/app/).*(id\d+)',
      '(.+spiegel.+/).+(a-\d+.*)',
      '(.+spiegel.+/[\d,]+.html)',
      '(.+amazon.+/gp/product/[A-Z0-9]+)',
      '(.+amazon[^/]+).*(/dp/[A-Z0-9]+)',
      '(.+huffington.+?/).*(n_\d+\.html)',
      '(.+support.google.*/answer.py\?).*(answer=\d+)',
      '(.+)/\?utm_source',
      '(.+/\d+)',
      '(.+)'
    ]
  end

  def simplify url
    suitable_substitution_patterns = @substitution_patterns.select { |p| url=~Regexp.new(p[0])}
    suitable_substitution_patterns.each { |p| url = url.sub(p[1], p[2])}

    if url.match(/mail.google/) 
      return url
    end

    suitable_patterns = @simplification_patterns.select { |pattern| url =~ Regexp.new(pattern) }
    regex_for_best_pattern = Regexp.new(suitable_patterns[0])
    url = regex_for_best_pattern.match(url).captures.join()

    url
  end

end
