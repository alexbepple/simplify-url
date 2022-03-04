import { assertThat, is } from 'hamjest'
import * as r from 'ramda'
import randomstring from 'randomstring'
import cleanUrl from './clean-url'

const assertClean = r.useWith(assertThat, [cleanUrl, is])
const assertUnchanged = r.converge(assertClean, [r.identity, r.identity])

describe('URL cleaner', () => {
  it('leaves URL in peace when there is nothing to clean up', () =>
    assertUnchanged('http://alex.bepple.de'))

  describe('removes common tracking search params', () => {
    it('removes trk_ search params', () =>
      assertClean('http://host.tld/?trk_foo=bar', 'http://host.tld/'))
    it('removes utm_ search params', () =>
      assertClean('http://host.tld/?utm_foo=bar', 'http://host.tld/'))
  })

  describe('Google', () => {
    it('keeps search query', () =>
      assertUnchanged('http://google.tld/search?q=foo+bar+baz'))
  })

  describe('Amazon', () => {
    it("use only the URL segment after 'dp'", () =>
      // I know no example with multiple suffix segments
      assertClean(
        'https://www.amazon.de/dp/after-dp/foo',
        'https://www.amazon.de/dp/after-dp'
      ))
    it("drop another segment before 'dp'", () =>
      // I know no example with multiple prefix segments
      assertClean(
        'http://amazon.de/foo/dp/after-dp',
        'http://amazon.de/dp/after-dp'
      ))
    it('drop query string', () =>
      assertClean(
        'http://amazon.de/dp/after-dp?foo=bar',
        'http://amazon.de/dp/after-dp'
      ))
    it('replaces old gp url with newer dp url', () =>
      assertClean(
        'https://www.amazon.de/gp/product/asin',
        'https://www.amazon.de/dp/asin'
      ))
  })

  describe('Gmail', () => {
    it('replaces search string', () => {
      assertClean(
        `https://mail.google.com/mail/u/0/#search/search+query+${randomstring.generate()}/FMxyz`,
        'https://mail.google.com/mail/u/0/#all/FMxyz'
      )
    })
    it('replaces inbox ref', () => {
      assertClean(
        'https://mail.google.com/mail/u/0/#inbox/FMxyz',
        'https://mail.google.com/mail/u/0/#all/FMxyz'
      )
    })
  })
})

describe('Text fragments', () => {
  // cp. https://wicg.github.io/scroll-to-text-fragment/#syntax
  it('are removed', () => {
    assertClean('http://host.tld/#:~:text=textStart', 'http://host.tld/')
  })
})
