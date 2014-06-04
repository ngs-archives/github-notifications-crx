'use strict'

loggedIn = no
count = 0
requesting = no
NOTIFICATIONS_URL = 'https://github.com/notifications'
ALARM_NAME = 'alerm_update_count'

window.updateCount = updateCount = (alarm)->
  return if requesting or alarm?.name && alarm.name != ALARM_NAME
  requesting = yes
  $.ajax
    url: NOTIFICATIONS_URL,
    headers:
      'X-PJAX':'true',
      'X-PJAX-Container':'#site-container',
      'X-Requested-With':'XMLHttpRequest'
    dataType: 'html'
    success: onAjaxSuccess
    error: onAjaxError

onAjaxSuccess = (res, statux, xhr)->
  requesting = no
  loggedIn = yes
  items = $(res).find '.list-group-item.js-notification'
  count = items.size()
  updateBadge()

onAjaxError = (xhr, status, err)->
  requesting = no
  loggedIn = no
  count = 0
  updateBadge()

updateBadge = ->
  text = if count > 0 then "#{count}" else ''
  ba = chrome.browserAction
  if loggedIn
    popup = 'popup.html'
    icon  = ''
  else
    popup = ''
    icon  = "-gray"
  ba.setBadgeText text: text
  ba.setPopup popup: popup
  ba.setIcon path:
    '19': "images/icon#{icon}-19.png"
    '38': "images/icon#{icon}-38.png"

openLogin = ->
  chrome.tabs.create url: LOGIN_URL unless loggedIn

chrome.browserAction.onClicked.addListener openLogin
chrome.tabs.onActivated.addListener updateCount
chrome.tabs.onUpdated.addListener updateCount
chrome.alarms.onAlarm.addListener updateCount
chrome.alarms.create ALARM_NAME, periodInMinutes: 1
updateBadge()
updateCount()
