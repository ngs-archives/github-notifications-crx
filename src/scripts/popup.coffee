'use strict'

NOTIFICATIONS_URL = 'https://github.com/notifications'
STATS_URL = 'https://github.com/_stats'

service   = analytics.getService 'github_notifications'
tracker   = service.getTracker 'UA-200187-37'
tracker.sendAppView 'Popup'

_ajax = jQuery.ajax
unless jQuery.ajax.__hacked
  jQuery.ajax = (options)->
    options.url = options.url.replace(/^chrome\-extension:\/\/[^\/]+/, '')
    options.url = 'https://github.com' + options.url unless /^https?:/.test options.url
    return if options.url is STATS_URL
    options.crossDomain = yes
    options.headers ||= {}
    _ajax.call jQuery, options
  jQuery.__hacked = yes

updateCount = ->
  setTimeout ->
    chrome.runtime.getBackgroundPage (bg)->
      bg?.updateCount?()
  , 1000

onAjaxSuccess = (res, statux, xhr)->
  res = $ "<div>#{res}</div>"
  res.find('meta[name="csrf-param"]').appendTo 'head'
  res.find('meta[name="csrf-token"]').appendTo 'head'
  container = res.find '.notifications-list'
  body = $('body').empty()
  unless container?.find('*').length > 0
    container = $ '<div class="no-unread" />'
    container.append res.find '.blankslate'
    container.append res.find '.inbox-zero-octocat'
  body.append container
  updateCount()

onAjaxError = (xhr, status, err)->
  updateCount()

$ ->
  $.ajax
    url: NOTIFICATIONS_URL,
    dataType: 'html'
    success: onAjaxSuccess
    error: onAjaxError

  $('body').on 'click', 'a[href]', ->
    url = $(@).attr 'href'
    unless /^https?:/.test url
      url = '/' + url unless url[0] is '/'
      url = 'https://github.com' + url
    chrome.tabs.create url: url
    tracker.sendEvent 'Link', 'Click'
    no

