# simplify-url

Some URLs on the net are overly long.

Why have
> <http://lifehacker.com/5926574/screenleap-for-gmail-offers-one+click-screen-sharing-from-your-inbox-or-google-contacts>

in your text when 
> <http://lifehacker.com/5926574> 

is just as good?

And let’s reduce
> <http://www.amazon.de/gp/product/B0088CG2S6/ref=s9_newr_gw_d80_g340_ir03?pf_rd_m=A3JWKAKR8XB7XF&pf_rd_s=center-2&pf_rd_r=1XKGD5MM7W03Y4WTZPDE&pf_rd_t=101&pf_rd_p=463375173&pf_rd_i=301128>.

to
> <http://www.amazon.de/gp/product/B0088CG2S6>

shall we?

If you do not want those monsters, e.g. as a service to the reader of your email or for your own sanity, this little tool for the Mac spares you from manually editing the URLs.


## Installation

* Clone or download.
* Done.


## Usage

* Running `simplify.url.rb` simplifies the URL that is on the system clipboard. That's it.

I run it through a simple Alfred 2 workflow:

1. Hotkey ⌥⌘C passes the current OS X selection to the workflow.
2. Bash runs `simplify.url.urb`.

The utility is destructive. If you have something on the clipboard that is not a URL, you probably will garble your clipboard. This does not bother me much right now. First, you run the utility yourself, so it's your responsibility. Second, if you are anxious about the contents of your clipboard, you probably should be using a clipboard manager anyway.


## Development

* Install Bundler if you don't have it: `gem install bundler`
* Install dependencies: `bundle install`
* Run tests: `bundle exec rspec`
* Hack away.

If you want to run tests continuously, `test.all.the.time` is your friend.
