import { assertThat, is } from 'hamjest'
import cleanUrl from './clean-url'

describe('URL cleaner', () => {
  it('leaves URL in peace when there is nothing to clean up', () => {
    const urlThatsAlreadyClean = 'http://alex.bepple.de'
    assertThat(cleanUrl(urlThatsAlreadyClean), is(urlThatsAlreadyClean))
  })
  describe('removes common tracking search params', () => {
    it('removes trk_ search params', () => {
      assertThat(
        cleanUrl('http://host.tld/?trk_foo=bar'),
        is('http://host.tld/')
      )
    })
    it('removes utm_ search params', () => {
      assertThat(
        cleanUrl('http://host.tld/?utm_foo=bar'),
        is('http://host.tld/')
      )
    })
  })
  describe('Google', () => {
    it('keeps search query', () => {
      assertThat(
        cleanUrl('http://google.tld/search?q=search+query'),
        'http://google.tld/search?q=search+query'
      )
    })
  })
  describe('Amazon', () => {
    it("use only the URL segment after 'dp'", () => {
      // I know no example with multiple suffix segments
      assertThat(
        cleanUrl('https://www.amazon.de/dp/after-dp/foo'),
        is('https://www.amazon.de/dp/after-dp')
      )
    })
    it("drop another segment before 'dp'", () => {
      // I know no example with multiple prefix segments
      assertThat(
        cleanUrl('http://amazon.de/foo/dp/after-dp'),
        is('http://amazon.de/dp/after-dp')
      )
    })
    it('drop query string', () => {
      assertThat(
        cleanUrl('http://amazon.de/dp/after-dp?foo=bar'),
        is('http://amazon.de/dp/after-dp')
      )
    })
  })
})
