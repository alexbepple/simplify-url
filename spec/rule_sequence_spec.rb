
require 'rule_sequence'

describe 'Rule sequence' do
  it 'is applicable if the first rule applies' do
    RuleSequence.new([
      ApplicableRule.new      
    ]).applies_to?('foo').should be_true
  end
  it 'is not applicable if no rules apply' do
    RuleSequence.new([]).applies_to?('foo').should be_false
  end
  it 'applies by consecutively applying all rules' do
    RuleSequence.new([
      FixedValuesRule.new('foo', 'bar'),
      FixedValuesRule.new('bar', 'baz')
    ]).apply('foo').should == 'baz'
  end
end

class ApplicableRule
  def applies_to? (input) true end
end
class FixedValuesRule
  def initialize fixed_input, fixed_output
    @fixed_input = fixed_input
    @fixed_output = fixed_output
  end
  def applies_to? (input) input == fixed_input end
  def apply (input) @fixed_output end
end
