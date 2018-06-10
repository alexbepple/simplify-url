import * as r from 'ramda'

const toPathComponents = r.split('/')
const toPathname = r.pipe(
  r.join('/'),
  r.concat('/')
)

const dropEverythingBeforeDp = r.dropWhile(r.complement(r.equals('dp')))
const cleanAmazonPathname = r.pipe(
  toPathComponents,
  dropEverythingBeforeDp,
  r.take(2),
  toPathname
)

export default (dirtyUrlString) => {
  const url = new URL(dirtyUrlString)
  if (url.hostname.indexOf('amazon') > -1) {
    url.pathname = cleanAmazonPathname(url.pathname)
    url.search = ''
    return url.toString()
  }
  return dirtyUrlString
}
