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

export default (dirtyUrlString) => {
  const url = new URL(dirtyUrlString)
  if (url.hostname.indexOf('amazon') > -1) {
    url.pathname = cleanAmazonPathname(url.pathname)
    url.search = ''
    return url.toString()
  }

  if (url.hostname.indexOf('mail.google.com') > -1) {
    url.hash = cleanGmailHash(url.hash)
    return url.toString()
  }

  if (r.contains('#:~:text')(url.hash)) {
    // This is a very dumb approach. But I have no need to refine it right now.
    url.hash = ''
    return url.toString()
  }

  if (!r.isEmpty(url.search)) {
    url.search = cleanQueryString(url.search)
    return url.toString()
  }

  return dirtyUrlString
}
