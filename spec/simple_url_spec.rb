# encoding: utf-8

require 'url'

def simplify test_data
  Url.new(test_data[0]).simplify.should == test_data[1]
end

describe 'Url Simplifier' do
  describe 'removes everything after a number' do
    it 'from a LH url' do
      simplify %w{
        http://lifehacker.com/5926574/screenleap-for-gmail-offers-one+click-screen-sharing-from-your-inbox-or-google-contacts
        http://lifehacker.com/5926574
      }
    end
    it 'from a The Changelog url' do
      simplify %w{
        http://thechangelog.com/post/26907189672/kineticjs-html5-canvas-drawing-made-easy
        http://thechangelog.com/post/26907189672
      }
    end
  end
  
  it 'removes crap from Amazon url' do
    simplify %w{
      http://www.amazon.de/gp/product/B0088CG2S6/ref=s9_newr_gw_d80_g340_ir03?pf_rd_m=A3JWKAKR8XB7XF&pf_rd_s=center-2&pf_rd_r=1XKGD5MM7W03Y4WTZPDE&pf_rd_t=101&pf_rd_p=463375173&pf_rd_i=301128
      http://www.amazon.de/gp/product/B0088CG2S6
    }
  end

  it 'removes utm_source crap' do
    simplify %w{
      http://osxdaily.com/2012/07/18/convert-dmg-to-cdr-or-iso-with-disk-utility/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+osxdaily+%28OS+X+Daily%29
      http://osxdaily.com/2012/07/18/convert-dmg-to-cdr-or-iso-with-disk-utility
    }
  end

  it "doesn't do nuthin' when nuthin' to do" do
    simplify %w{
      http://a.b.c
      http://a.b.c
    }
  end

end
