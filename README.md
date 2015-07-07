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

If you do not want those monsters, e.g. as a service to the reader of your email or for your own sanity, this little tool spares you from manually editing the URLs.


## Installation

Clone or download.

Personally I use [peru](https://github.com/buildinspace/peru) for repos from others, so that I can update them easily at once.


## Usage

`simplify.url.rb` simplifies the URL that you pass to it as the first parameter and prints the simplified URL to stdout.

I use invoke the script on a Mac through a simple Alfred 2 workflow:

1. Hotkey ⌥⌘C passes the current OS X selection to the workflow.
2. Zsh runs `simplify.url.rb`.
3. Alfred puts the output of the script back on the clipboard.


## Development

* Install Bundler if you don't have it: `gem install bundler`
* Install dependencies: `bundle install`
* Run tests: `bundle exec rspec`
* Hack away.

If you want to run tests continuously, `make tdd` is your friend.
