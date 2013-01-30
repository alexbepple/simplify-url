# encoding: utf-8

require 'url'

describe 'Url Simplifier' do

  it "leaves urls in peace when nuthin' to do" do
    leave_unchanged 'http://a.b.c'
    leave_unchanged 'http://www.spiegel.de/netzwelt/technologie/0,1518,370532,00.html'
    leave_unchanged 'https://mail.google.com/mail/u/0/#all/13879cf0284080c0'
  end

  describe 'removes everything after a number' do
    it 'for Lifehacker' do
      simplify %w{
        http://lifehacker.com/5926574/screenleap-for-gmail-offers-one+click-screen-sharing-from-your-inbox-or-google-contacts
        http://lifehacker.com/5926574
      }
    end
    it 'for Gizmodo' do
      simplify %w{
        http://gizmodo.com/5341915/android-hacking-for-the-masses
        http://gizmodo.com/5341915
      }
    end
    it 'for Apple forums' do
      simplify %w{
        https://discussions.apple.com/message/16611473#16611473 
        https://discussions.apple.com/message/16611473
      }
    end
    it 'even if there is no protocol in the url' do
      simplify %w{
        gizmodo.com/5341915/android-hacking-for-the-masses
        gizmodo.com/5341915
      }
    end
  end
  
  it 'removes utm_source crap' do
    simplify %w{
      http://osxdaily.com/2012/07/18/convert-dmg-to-cdr-or-iso-with-disk-utility/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+osxdaily+%28OS+X+Daily%29
      http://osxdaily.com/2012/07/18/convert-dmg-to-cdr-or-iso-with-disk-utility
    }
  end

  describe 'removes unnecessary bits' do
    it 'for App Store' do
      simplify %w{
        http://itunes.apple.com/app/calendars-google-calendar/id371434886
        http://itunes.apple.com/app/id371434886
      }
    end
    it 'for Spiegel Online' do
      simplify %w{
        http://www.spiegel.de/kultur/musik/debuetalben-von-teed-lemonade-christian-loeffler-neue-techno-impulse-a-846509.html
        http://www.spiegel.de/kultur/musik/a-846509.html
      }
    end
    it 'for Amazon' do
      simplify %w{
        http://www.amazon.de/gp/product/B0088CG2S6/ref=s9_newr_gw_d80_g340_ir03?pf_rd_m=A3JWKAKR8XB7XF&pf_rd_s=center-2&pf_rd_r=1XKGD5MM7W03Y4WTZPDE&pf_rd_t=101&pf_rd_p=463375173&pf_rd_i=301128
        http://www.amazon.de/gp/product/B0088CG2S6
      }
      simplify %w{
        http://www.amazon.de/Philips-LED-Birne-Tropfenform-matt-19564100/dp/B0085WGRA2/ref=sr_1_5?s=lighting&ie=UTF8&qid=1354224824&sr=1-5
        http://www.amazon.de/dp/B0085WGRA2
      }
    end

  end

  describe 'references Gmail messages in a stable manner' do
    it 'when url contains reference to a label' do
      simplify %w{
        https://mail.google.com/mail/u/0/#inbox/13879cf0284080c0 
        https://mail.google.com/mail/u/0/#all/13879cf0284080c0
      }
    end
    it 'when url contains search criteria' do
      simplify %w{
        https://mail.google.com/mail/u/1/#search/funnel/138e2def960ca553 
        https://mail.google.com/mail/u/1/#all/138e2def960ca553
      }
    end
  end
  
end


def simplify test_data
  defaults = {
    'remove everything after id' => %w{lifehacker gizmodo discussions.apple}
  }
  UrlSimplifier.new(defaults).simplify(test_data[0]).should == test_data[1]
end

def leave_unchanged url
  simplify [url, url]
end
