# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http://example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require underscore
#= require json2
#= require backbone
#= require haml
#= require hamljs_escape
#= require accounting.min
#= require iphone-style-checkboxes
#= require_tree .

class window.Application extends Backbone.View
  initialize: ->
    @toolbar = new View.Toolbar()

  render: ->
    @$el.append @toolbar.render().el
    this

