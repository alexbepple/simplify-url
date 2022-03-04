import * as r from 'ramda'
import * as qs from 'query-string'
import { urlT } from './url-type'

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
    (url) => url.hostname.includes('amazon'),
    r.pipe(
      urlT.over.pathname(cleanAmazonPathname),
      urlT.clear.search
    )
  ],
  [
    (url) => url.hostname.includes('mail.google.com'),
    urlT.over.hash(cleanGmailHash)
  ],
  [(url) => r.contains('#:~:text')(url.hash), urlT.clear.hash],
  [(url) => !r.isEmpty(url.search), urlT.over.search(cleanQueryString)],
  [r.T, r.identity]
])

export default r.pipe(
  (dirtyUrlString) => new URL(dirtyUrlString),
  cleanDirtyUrlObject,
  r.toString
)
