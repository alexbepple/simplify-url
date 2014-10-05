require 'substitution_rule'
require 'stripping_rule'
require 'rule_sequence'

class UrlSimplifier

  def initialize
    @gmail_rulez = RuleSequence.new SubstitutionRules.create [
      [/mail.google/, %r{#(advanced-search|search|label)/[^/]+}, '#all'],
      [/mail.google/,                                %r{#[^/]+}, '#all'],
      ]
    @amazon_rulez = RuleSequence.new [
      SubstitutionRule.new(/amazon/, %r{gp/product}, 'dp'),
    ] + StrippingRules.create(%w{
      (.+amazon.+/gp/product/[A-Z0-9]+)
      (.+amazon[^/]+).*(/dp/[A-Z0-9]+)
    })
    @stripping_rules = StrippingRules.create %w{
      (.*chrome.google.com/webstore/detail/).*/([a-z]+)
      (.*youtube.*/watch\?v=.*)&
      (.*play.google.com/store/apps/details\?id=.*)&
      (.+apple.+/app/).*(id\d+)
      (.*lifehacker.+/)[^\d]*(\d+)
      (.+spiegel.+/).+(a-\d+.*)
      (.+spiegel.+/[\d,]+.html)
      (.+huffington.+?/).*(n_\d+\.html)
      (.+support.google.*/answer.py\?).*(answer=\d+)
      (.+)\?utm_
      (.+/\d+)
      (.+)
    }
  end

  def simplify url
    all_rules = [@gmail_rulez, @amazon_rulez] + @stripping_rules
    best_rule = all_rules.find { |rule| rule.applies_to? url }
    best_rule.apply url
  end

end
