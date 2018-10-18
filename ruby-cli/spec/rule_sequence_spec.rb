
require 'rule_sequence'

describe 'Rule sequence' do
  it 'is applicable if the first rule applies' do
    applicable_rule = stub('applicable rule')
    applicable_rule.stub(:applies_to?).and_return(true)
    RuleSequence.new([applicable_rule]).applies_to?('foo').should be_true
  end
  it 'is not applicable if no rules apply' do
    RuleSequence.new([]).applies_to?('foo').should be_false
  end
  it 'applies by consecutively applying all rules' do
    RuleSequence.new([
      fixed_values_rule('foo', 'bar'),
      fixed_values_rule('bar', 'baz')
    ]).apply('foo').should == 'baz'
  end
end

def fixed_values_rule from, to
  rule = stub("fixed-values rule '#{from}'→'#{to}'")
  rule.should_receive(:apply).with(from).and_return(to)
  rule
end
