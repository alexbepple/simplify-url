require 'substitution_rule'
require 'stripping_rule'

class UrlSimplifier

  def initialize
    @substitution_rules = SubstitutionRule.create [
      [/mail.google/, %r{#(advanced-search|search|label)/[^/]+}, '#all'],
      [/mail.google/,                                %r{#[^/]+}, '#all'],
      [/amazon/, %r{gp/product}, 'dp']
      ]
    @stripping_rules = StrippingRule.create %w{
      (.*chrome.google.com/webstore/detail/).*/([a-z]+)
      (.*youtube.*/watch\?v=.*)&
      (.*play.google.com/store/apps/details\?id=.*)&
      (.+apple.+/app/).*(id\d+)
      (.*lifehacker.+/)[^\d]*(\d+)
      (.+spiegel.+/).+(a-\d+.*)
      (.+spiegel.+/[\d,]+.html)
      (.+amazon.+/gp/product/[A-Z0-9]+)
      (.+amazon[^/]+).*(/dp/[A-Z0-9]+)
      (.+huffington.+?/).*(n_\d+\.html)
      (.+support.google.*/answer.py\?).*(answer=\d+)
      (.+)\?utm_
      (.+/\d+)
      (.+)
    }
  end

  def simplify url
    @substitution_rules.each { |rule| url = rule.apply(url) }

    if url.match(/mail.google/) 
      return url
    end

    applicable_rules = @stripping_rules.select { |rule| rule.applies_to? url }
    best_rule = applicable_rules[0]
    best_rule.apply url
  end

end
