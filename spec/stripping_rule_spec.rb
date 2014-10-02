
require 'stripping_rule'

describe 'StrippingRule' do
  context '' do
    rule = StrippingRule.new(/foo/)
    it 'is applicable when pattern matches' do
      rule.applies_to?('foo').should be_true
    end
    it 'and only then' do
      rule.applies_to?('bar').should be_false
    end
  end

  it 'applies by joining all capture groups' do
    rule = StrippingRule.new(/1(2)3(4)5/)
    rule.apply('12345').should == '24'
  end
end
