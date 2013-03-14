class UrlSimplifier

  def initialize defaults
    remove_everything_after_id = defaults['remove everything after id'].join('|')

    @simplification_patterns = [
      '(.+apple.+/app/).*(id\d+)',
      '(.+spiegel.+/).+(a-\d+.*)',
      '(.+spiegel.+/[\d,]+.html)',
      '(.+amazon.+/gp/product/[A-Z0-9]+)',
      '(.+amazon[^/]+).*(/dp/[A-Z0-9]+)',
      '(.+huffington.+?/).*(n_\d+\.html)',
      '(.+support.google.*/answer.py\?).*(answer=\d+)',
      '(.*(?:' + remove_everything_after_id + ').+/\d+)',
      '(.+)/\?utm_source',
      '(.+)'
    ]
  end

  def simplify url
    suitable_patterns = @simplification_patterns.select { |pattern| url =~ Regexp.new(pattern) }
    regex_for_best_pattern = Regexp.new(suitable_patterns[0])
    url = regex_for_best_pattern.match(url).captures.join()

    if url.match /amazon/
      url.sub!(%r{gp/product}, 'dp')
    end
    if url.match(/mail.google/) 
      [
        %r{#(search|label)/[^/]+}, 
        %r{#[^/]+}
      ].each do |unstable_reference|
        url.sub!(unstable_reference, '#all')
      end
    end

    url
  end

end
