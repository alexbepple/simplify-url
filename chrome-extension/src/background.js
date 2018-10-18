/* global document, chrome */

import cleanUrl from './clean-url'

let textToPutOnClipboard

document.addEventListener('copy', (e) => {
  e.clipboardData.setData('text/plain', textToPutOnClipboard)
  e.preventDefault()
})

chrome.browserAction.onClicked.addListener((tab) => {
  const cleanedUrl = cleanUrl(tab.url)

  chrome.tabs.update(tab.id, { url: cleanedUrl })

  textToPutOnClipboard = cleanedUrl
  document.execCommand('copy')
})
