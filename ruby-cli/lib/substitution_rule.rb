class SubstitutionRule
  def initialize(criterion, to_replace, replace_with)
    @criterion = criterion
    @to_replace = to_replace
    @replace_with = replace_with
  end

  def applies_to? input
    input.match(@criterion)
  end

  def apply(input)
    return input unless applies_to? input
    return input.sub(@to_replace, @replace_with)
  end
end

class SubstitutionRules
  def self.create rules
    rules.map { |rule| SubstitutionRule.new rule[0], rule[1], rule[2] }
  end
end
