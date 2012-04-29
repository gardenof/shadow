originalHaml = Haml
window.Haml = (src, options) ->
  originalHaml src,
               _.extend(options || {}, escapeHtmlByDefault: true)

_.extend Haml, originalHaml

