
require 'substitution_rule'

describe 'Substitution rule' do
  context '' do
    rule = SubstitutionRule.new(/foo/, nil, nil)
    it 'is applicable when pattern matches' do
      rule.applies_to?('foo').should be_true
    end
    it 'and only then' do
      rule.applies_to?('bar').should be_false
    end
    it 'returns original input when not applicable' do
      rule.apply('bar').should == 'bar'
    end
  end

  it 'that matches applies substitution' do
    rule = SubstitutionRule.new(/.*/, /foo/, 'bar')
    rule.apply('foo').should == 'bar'
  end
end
