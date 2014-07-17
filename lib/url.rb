require 'substitution_rule'

class UrlSimplifier

  def initialize
    @substitution_rules = SubstitutionRule.create [
      [/mail.google/, %r{#(advanced-search|search|label)/[^/]+}, '#all'],
      [/mail.google/,                                %r{#[^/]+}, '#all'],
      [/amazon/, %r{gp/product}, 'dp']
      ]
    @simplification_patterns = [
      '(.*youtube.*/watch\?v=.*)&',
      '(.*play.google.com/store/apps/details\?id=.*)&',
      '(.+apple.+/app/).*(id\d+)',
      '(.*lifehacker.+/)[^\d]*(\d+)',
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
    @substitution_rules.each { |rule| url = rule.apply(url) }

    if url.match(/mail.google/) 
      return url
    end

    suitable_patterns = @simplification_patterns.select { |pattern| url =~ Regexp.new(pattern) }
    regex_for_best_pattern = Regexp.new(suitable_patterns[0])
    url = regex_for_best_pattern.match(url).captures.join()

    url
  end

end
