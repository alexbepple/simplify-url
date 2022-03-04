/* global document, chrome */

import cleanUrl from './clean-url.js'

let textToPutOnClipboard

document.addEventListener('copy', (event) => {
  event.clipboardData.setData('text/plain', textToPutOnClipboard)
  event.preventDefault()
})

chrome.browserAction.onClicked.addListener((tab) => {
  const cleanedUrl = cleanUrl(tab.url)

  chrome.tabs.update(tab.id, { url: cleanedUrl })

  textToPutOnClipboard = cleanedUrl
  document.execCommand('copy')
})
