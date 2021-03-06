#= require rendering
#
window.HtmlHelpers =
  open_tag: (tag, attributes) ->
    "<" + tag + " " + attributeDefs(attributes) + ">"

  close_tag: (tag) ->
    "</" + tag + ">"

  content_tag: (tag, content, attributes, options) ->
    HtmlHelpers.open_tag(tag, attributes) +
      (if options?.safe_content
        content
      else
        Haml.html_escape(content)) +
    HtmlHelpers.close_tag(tag)

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

  form_for: (object, url) ->
    new FormBuilder(object, url)

class FormBuilder
  constructor: (object, url) ->
    _.extend this, HtmlHelpers
    this.object = object
    this.url = url

  form_action: ->
    if this.url
      return this.url

    this.object.url()

  fake_method: ->
    if this.object.id
      'PUT'
    else
      'POST'

  label: (attribute) ->
    this.content_tag('label', attribute.humanize()) + ' '

  start_form: ->
    this.open_tag('form', action: this.form_action(), method: 'POST') +
    this.content_tag('input', '', { type: 'hidden', name: '_method', value: this.fake_method()})

  end_form: ->
    HtmlHelpers.close_tag 'form'

  text_field: (attribute) ->
    this.content_tag(
      'input',
      '',
      type: 'text'
      name: this.input_name(attribute)
      value: this.input_value(attribute)
    )

  radio_button: (tag_name, tag_value) ->
    this.content_tag(
      'input',
      '',
      type: 'radio'
      name: this.input_name(tag_name)
      value: tag_value
      checked: this.are_you_checked(tag_name,tag_value)
    )

  check_box: (tag_name) ->
    this.content_tag(
      'input',
      '',
      type: 'hidden'
      name: this.input_name(tag_name)
      value: 0
    ) +
    this.content_tag(
      'input',
      '',
      type: 'checkbox'
      name: this.input_name(tag_name)
      value: 1
      checked: this.are_you_checked(tag_name, "true")
    )

  are_you_checked: (tag_name, value) ->
    if this.input_value(tag_name) == value
      checked_value = "checked"
    else
      checked_value = undefined

  hidden_field: (tag_name, value) ->
    this.content_tag(
      'input',
      '',
      type: 'hidden'
      name: this.input_name(tag_name)
      value: value
    )

  collection_select: (attribute, collection, val_attr, text_attr, options) ->
    blank = if options?.include_blank
              this.content_tag 'option', ''
            else
              ''

    this.content_tag(
      'select',
      blank + this.options_from_collection_for_select(collection, val_attr, text_attr, this.input_value(attribute)),
      { name: this.input_name(attribute) },
      safe_content: true
    )

  options_from_collection_for_select: (collection, val_attr, text_attr, selected) ->
    make_option = (object) =>
      value = this.toParam(object.get(val_attr))

      this.content_tag(
        'option',
        object.get(text_attr),
        value: value
        selected: if value == selected then 'selected' else undefined
      )

    _.foldl collection,
            (result,o) -> result + make_option(o),
            ''

  input_name: (attribute) ->
    "#{this.object_name()}[#{attribute}]"

  object_name: ->
    this.object.model_name

  submit: (text) ->
    this.content_tag(
      'input',
      '',
      type: 'submit'
      value: text || 'Submit'
    )

  input_value: (attribute) ->
    this.toParam(this.object.get(attribute))

  toParam: (val) ->
    if _.isUndefined(val) || _.isNull(val)
      ''
    else
      "#{val}"

String::toUnderscore = ->
	this.replace(/([A-Z])/g, ($1) -> "_" + $1.toLowerCase()).substr(1)

String::humanize = ->
  this.replace(/_id$/, '').replace(/_/g, ' ').capitalize()

String::capitalize = ->
  this.replace /./, ($1) -> $1.toUpperCase()

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
