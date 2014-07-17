# encoding: utf-8

require 'url'

describe 'Url Simplifier' do

  it "leaves urls in peace when nuthin' to do" do
    leave_unchanged 'http://a.b.c'
    leave_unchanged 'http://www.spiegel.de/cat/subcat/0,42,42,00.html'
    leave_unchanged 'https://mail.google.com/mail/u/0/#all/42f'
  end

  describe 'removes everything after a number' do
    it 'for Gizmodo' do
      simplify %w{
        http://gizmodo.com/42/foo
        http://gizmodo.com/42
      }
    end
    it 'for Apple forums' do
      simplify %w{
        https://discussions.apple.com/message/42#42
        https://discussions.apple.com/message/42
      }
    end
    it 'even if there is no protocol in the url' do
      simplify %w{
        gizmodo.com/42/foo
        gizmodo.com/42
      }
    end
  end
  
  it 'removes utm_source crap' do
    simplify %w{
      http://osxdaily.com/2012/07/18/foo/?utm_source=foo
      http://osxdaily.com/2012/07/18/foo
    }
  end

  describe 'removes unnecessary bits' do
    describe 'for Lifehacker URLs' do
      it 'in slash style' do
        simplify %w{
          http://lifehacker.com/42/foo
          http://lifehacker.com/42
        }
      end
      it 'in hyphen style' do
        simplify %w{
          lifehacker.com/foo-42
          lifehacker.com/42
        }
      end
    end
    it 'for App Store' do
      simplify %w{
        http://itunes.apple.com/app/foo/id42
        http://itunes.apple.com/app/id42
      }
    end
    it 'for Spiegel Online' do
      simplify %w{
        http://www.spiegel.de/kultur/musik/foo-a-42.html
        http://www.spiegel.de/kultur/musik/a-42.html
      }
    end
    it 'for Amazon' do
      simplify %w{
        http://www.amazon.de/gp/product/B0088CG2S6/foo
        http://www.amazon.de/dp/B0088CG2S6
      }
      simplify %w{
        http://www.amazon.de/foo/dp/B0085WGRA2/foo
        http://www.amazon.de/dp/B0085WGRA2
      }
    end
    it 'for Huffington Post' do
      simplify %w{
        http://www.huffingtonpost.ca/2011/08/25/foo_n_42.html?foo
        http://www.huffingtonpost.ca/n_42.html
      }
    end
    it 'for Google support forums' do
      simplify %w{
        https://support.google.com/mobile/bin/answer.py?foo&answer=42
        https://support.google.com/mobile/bin/answer.py?answer=42
      }
    end
    it 'for Google Play Store' do
      simplify %w{
        play.google.com/store/apps/details?id=foo.bar&feature=search_result#?t=aA0
        play.google.com/store/apps/details?id=foo.bar
      }
    end
    it 'for Youtube' do
      simplify %w{
        youtube.com/watch?v=aA0&feature=foo
        youtube.com/watch?v=aA0
      }
    end
  end

  describe 'references Gmail messages in a stable manner' do
    it 'from inbox' do
      simplify %w{
        https://mail.google.com/mail/u/0/#inbox/42f
        https://mail.google.com/mail/u/0/#all/42f
      }
    end
    it 'from search' do
      simplify %w{
        https://mail.google.com/mail/u/1/#search/foo/42
        https://mail.google.com/mail/u/1/#all/42
      }
    end
    it 'from advanced search' do
      simplify %w{
        https://mail.google.com/mail/u/1/#advanced-search/foo=bar&bar=foo/42
        https://mail.google.com/mail/u/1/#all/42
      }
    end
    it 'from label' do
      simplify %w{
        https://mail.google.com/mail/u/0/#label/foo/42
        https://mail.google.com/mail/u/0/#all/42
      }
    end
  end
  
end


def simplify test_data
  UrlSimplifier.new().simplify(test_data[0]).should == test_data[1]
end

def leave_unchanged url
  simplify [url, url]
end
