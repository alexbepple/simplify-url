import { assertThat, is } from 'hamjest'
import cleanUrl from './clean-url'

describe('URL cleaner', () => {
  it('leaves URL in peace when there is nothing to clean up', () => {
    const urlThatsAlreadyClean = 'http://alex.bepple.de'
    assertThat(cleanUrl(urlThatsAlreadyClean), is(urlThatsAlreadyClean))
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
