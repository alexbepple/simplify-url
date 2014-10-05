require 'substitution_rule'
require 'stripping_rule'
require 'rule_sequence'

class UrlSimplifier

  def initialize
    @gmail_rules = RuleSequence.new SubstitutionRules.create [
      [/mail.google/, %r{#(advanced-search|search|label)/[^/]+}, '#all'],
      [/mail.google/,                                %r{#[^/]+}, '#all'],
      ]
    @amazon_rules = RuleSequence.new [
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
    }
    @fallback_leave_unchanged = StrippingRule.new '(.+)'
  end

  def simplify url
    all_rules = [@gmail_rules, @amazon_rules] + @stripping_rules + [@fallback_leave_unchanged]
    best_rule = all_rules.find { |rule| rule.applies_to? url }
    best_rule.apply url
  end

end
