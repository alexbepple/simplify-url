import { assertThat, is } from 'hamjest'
import * as r from 'ramda'
import randomstring from 'randomstring'
import cleanUrl from './clean-url'

const assertClean = r.useWith(assertThat, [cleanUrl, is])
const assertUnchanged = r.converge(assertClean, [r.identity, r.identity])

it('Leave URL in peace when there is nothing to clean up', () => {
  assertUnchanged('http://alex.bepple.de')
})

describe('Remove common tracking search params', () => {
  it('remove trk_ search params', () => {
    assertClean('http://host.tld/?trk_foo=bar', 'http://host.tld/')
  })
  it('remove utm_ search params', () => {
    assertClean('http://host.tld/?utm_foo=bar', 'http://host.tld/')
  })
})

it('Keep Google search query intact', () => {
  assertUnchanged('http://google.tld/search?q=foo+bar+baz')
})

describe('Strip Amazon product URLs to the bones', () => {
  it("use only the URL segment after 'dp'", () => {
    // I know no example with multiple suffix segments
    assertClean(
      'https://www.amazon.de/dp/after-dp/foo',
      'https://www.amazon.de/dp/after-dp'
    )
  })
  it("drop another segment before 'dp'", () => {
    // I know no example with multiple prefix segments
    assertClean(
      'http://amazon.de/foo/dp/after-dp',
      'http://amazon.de/dp/after-dp'
    )
  })
  it('drop query string', () => {
    assertClean(
      'http://amazon.de/dp/after-dp?foo=bar',
      'http://amazon.de/dp/after-dp'
    )
  })
  it('replace old gp url with newer dp url', () => {
    assertClean(
      'https://www.amazon.de/gp/product/asin',
      'https://www.amazon.de/dp/asin'
    )
  })
})

describe('Make Gmail URLs stable in time', () => {
  it('replace search interaction', () => {
    assertClean(
      `https://mail.google.com/mail/u/0/#search/search+query+${randomstring.generate()}/FMxyz`,
      'https://mail.google.com/mail/u/0/#all/FMxyz'
    )
  })
  it('replace inbox ref', () => {
    assertClean(
      'https://mail.google.com/mail/u/0/#inbox/FMxyz',
      'https://mail.google.com/mail/u/0/#all/FMxyz'
    )
  })
})

it('Remove text fragments', () => {
  // Cp. https://wicg.github.io/scroll-to-text-fragment/#syntax
  assertClean('http://host.tld/#:~:text=textStart', 'http://host.tld/')
})
