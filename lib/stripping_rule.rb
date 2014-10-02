
class StrippingRule
  def initialize pattern
    @regex = Regexp.new(pattern)
  end

  def applies_to? input
    input =~ @regex
  end

  def apply input
    return input unless applies_to? input
    @regex.match(input).captures.join()
  end

  def self.create patterns
    patterns.map { |pattern| StrippingRule.new pattern }
  end
end

