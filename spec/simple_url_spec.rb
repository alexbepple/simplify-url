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
  
  it 'removes crap from Amazon url' do
    Url.new('http://www.amazon.de/gp/product/B0088CG2S6/ref=s9_newr_gw_d80_g340_ir03?pf_rd_m=A3JWKAKR8XB7XF&pf_rd_s=center-2&pf_rd_r=1XKGD5MM7W03Y4WTZPDE&pf_rd_t=101&pf_rd_p=463375173&pf_rd_i=301128').simplify.should == 'http://www.amazon.de/gp/product/B0088CG2S6'
  end
end
