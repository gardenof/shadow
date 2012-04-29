#= require rendering
#
window.HtmlHelpers =
  link_to: (text, path) =>
    "<a href='#{Haml.html_escape(path)}'>#{Haml.html_escape(text)}</a>"

  image_tag: (src, options = {}) =>
    "<img src='/assets/#{Haml.html_escape(src)}' " +
      "alt='#{Haml.html_escape(options.alt)}'/>"

Rendering.helpers.html = HtmlHelpers
