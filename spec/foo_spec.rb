# encoding: utf-8

require 'url'

describe 'Url Simplifier' do
  it 'removes everything after the number from a LH url' do
    Url.new('http://lifehacker.com/5926574/screenleap-for-gmail-offers-one+click-screen-sharing-from-your-inbox-or-google-contacts').simplify.should == 'http://lifehacker.com/5926574'
  end
end
