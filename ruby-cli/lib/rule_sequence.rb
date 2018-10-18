
class RuleSequence
  def initialize rules
    @rules = rules
  end

  def applies_to? input
    @rules.any? { |rule| rule.applies_to? input }
  end

  def apply input
    @rules.inject(input) { |result, rule| rule.apply(result) }
  end
end

