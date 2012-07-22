# encoding: utf-8

require 'url'

describe 'Url Simplifier' do
  describe 'removes everything after a number' do
    it 'from a LH url' do
      Url.new('http://lifehacker.com/5926574/screenleap-for-gmail-offers-one+click-screen-sharing-from-your-inbox-or-google-contacts').simplify.should == 'http://lifehacker.com/5926574'
    end
    it 'from a The Changelog url' do
      Url.new('http://thechangelog.com/post/26907189672/kineticjs-html5-canvas-drawing-made-easy').simplify.should == 'http://thechangelog.com/post/26907189672'
    end
  end
end
