
class RuleSequence
  def initialize rules
    @rules = rules
  end

  def applies_to? input
    @rules.any? { |rule| rule.applies_to? input }
  end

  def apply input
    result = input
    @rules.each { |rule| result = rule.apply(result) }
    result
  end
end

