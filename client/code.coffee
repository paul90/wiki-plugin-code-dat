###
 * Federated Wiki : Code Plugin
 *
 * Licensed under the MIT license.
 * https://github.com/fedwiki/wiki-plugin-code/blob/master/LICENSE.txt
###

escape = (str) ->
  String(str)
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')

class window.plugins.code
  load = (callback) ->
    pluginOrigin = new URL(wiki.pluginRoutes["code"])
    scriptURL = pluginOrigin + '/client/prettify.js'
    cssURL = pluginOrigin + '/client/prettify.css'
    wiki.getScript scriptURL, callback
    if !$("link[href='#{cssURL}']").length
      $("<link href='#{cssURL}' rel='stylesheet' type='text/css'>").appendTo("head")

  @emit: (div, item) ->
    load -> div.append "<pre class='prettyprint'>#{prettyPrintOne(escape(item.text))}</pre>"
  @bind: (div, item) ->
    load -> div.dblclick -> wiki.textEditor div, item
