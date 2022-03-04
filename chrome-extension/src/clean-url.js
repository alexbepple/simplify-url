import * as r from 'ramda'
import * as qs from 'query-string'

const toPathComponents = r.split('/')
const toPathname = r.pipe(
  r.join('/'),
  r.concat('/')
)

const dropEverythingBeforeDp = r.dropWhile(r.complement(r.equals('dp')))
const cleanAmazonPathname = r.pipe(
  r.replace('gp/product', 'dp'),
  toPathComponents,
  dropEverythingBeforeDp,
  r.take(2),
  toPathname
)

const cleanQueryString = r.pipe(
  qs.parse,
  r.pick(['q']),
  qs.stringify,
  r.replace(/%20/g, '+')
)

const cleanGmailHash = r.pipe(
  r.replace(/#search\/[^/]+/, '#all'),
  r.replace('#inbox', '#all')
)

const cleanDirtyUrlObject = r.cond([
  [
    (url) => url.hostname.indexOf('amazon') > -1,
    r.tap((url) => {
      url.pathname = cleanAmazonPathname(url.pathname)
      url.search = ''
    })
  ],
  [
    (url) => url.hostname.indexOf('mail.google.com') > -1,
    r.tap((url) => {
      url.hash = cleanGmailHash(url.hash)
    })
  ],
  [
    (url) => r.contains('#:~:text')(url.hash),
    r.tap((url) => {
      // This is a very dumb approach. But I have no need to refine it right now.
      url.hash = ''
    })
  ],
  [
    (url) => !r.isEmpty(url.search),
    r.tap((url) => {
      url.search = cleanQueryString(url.search)
    })
  ],
  [r.T, r.identity]
])

export default r.pipe(
  (dirtyUrlString) => new URL(dirtyUrlString),
  cleanDirtyUrlObject,
  r.toString
)
