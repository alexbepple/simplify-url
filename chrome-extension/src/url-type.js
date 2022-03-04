import * as r from 'ramda'

const overUrlProp = r.curry((prop, fn, url) => {
  url[prop] = fn(url[prop])
  return url
})
const clearUrlProp = overUrlProp(r.__, () => '')

export const urlT = {
  over: {
    hash: overUrlProp('hash'),
    pathname: overUrlProp('pathname'),
    search: overUrlProp('search'),
  },
  clear: {
    hash: clearUrlProp('hash'),
    search: clearUrlProp('search'),
  },
}
