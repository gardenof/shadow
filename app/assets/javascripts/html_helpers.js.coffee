#= require rendering
#
window.HtmlHelpers =
  content_tag: (tag, content, attributes) ->
    "<" + tag + " " + attributeDefs(attributes) + ">" +
      Haml.html_escape(content) +
    "</" + tag + ">"

  link_to: (text, path, options) ->
    attributes = _.clone(options || {})

    if attributes.method
      attributes['data-method'] = attributes.method
      attributes.method = undefined

    if attributes.confirm
      attributes['data-confirm'] = attributes.confirm
      attributes.confirm = undefined

    attributes.href = path

    HtmlHelpers.content_tag 'a', text, attributes

  image_tag: (src, options = {}) ->
    HtmlHelpers.content_tag(
      'img',
      '',
      _.extend({src: '/assets/' + src}, options)
    )

attributeDefs = (attributes) ->
  _.foldl attributes,
          ((s, value, name) ->
            if _.isUndefined value
              return s

            str = name + '="' + Haml.html_escape(value) + '"'
            if s
              s + ", " + str
            else
              str),
           ""
Rendering.helpers.html = HtmlHelpers
