var textToPutOnClipboard;

document.addEventListener("copy", function(e) {
  e.clipboardData.setData("text/plain", textToPutOnClipboard);
  e.preventDefault();
});

chrome.browserAction.onClicked.addListener(function(tab) {
  chrome.tabs.query({ active: true, currentWindow: true }, function(tabs) {
    textToPutOnClipboard = tabs[0].url;
    document.execCommand("copy");
  });
});
