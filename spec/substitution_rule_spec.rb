# encoding: utf-8

require 'substitution_rule'

describe 'Substitution rule' do
  it 'that matches applies substitution' do
    rule = SubstitutionRule.new(/.*/, /foo/, 'bar')
    rule.apply('foo').should == 'bar'
  end

  it 'that doesn’t match returns the input unmodified' do
    rule = SubstitutionRule.new(/bar/, /foo/, 'bar')
    rule.apply('foo').should == 'foo'
  end
end
