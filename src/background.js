import cleanUrl from './clean-url.js'

var textToPutOnClipboard

document.addEventListener('copy', function(e) {
  e.clipboardData.setData('text/plain', textToPutOnClipboard)
  e.preventDefault()
})

chrome.browserAction.onClicked.addListener(function(tab) {
  chrome.tabs.query({ active: true, currentWindow: true }, function(tabs) {
    const tab = tabs[0]
    const cleanedUrl = cleanUrl(tab.url)

    chrome.tabs.update(tab.id, { url: cleanedUrl })

    textToPutOnClipboard = cleanedUrl
    document.execCommand('copy')
  })
})
