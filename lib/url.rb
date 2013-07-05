class UrlSimplifier

  def initialize
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
    if url.match(/mail.google/) 
      [
        %r{#(search|label)/[^/]+}, 
        %r{#[^/]+}
      ].each do |unstable_reference|
        url.sub!(unstable_reference, '#all')
      end
      return url
    end

    suitable_patterns = @simplification_patterns.select { |pattern| url =~ Regexp.new(pattern) }
    regex_for_best_pattern = Regexp.new(suitable_patterns[0])
    url = regex_for_best_pattern.match(url).captures.join()

    if url.match(/amazon/)
      url.sub!(%r{gp/product}, 'dp')
    end

    url
  end

end
