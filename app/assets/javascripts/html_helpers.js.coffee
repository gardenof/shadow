#= require rendering
#
window.HtmlHelpers =
  link_to: (text, path) =>
    "<a href='#{path}'>#{text}</a>"

Rendering.helpers.html = HtmlHelpers
