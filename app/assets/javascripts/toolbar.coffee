#=require view

class View.Toolbar extends Backbone.View
  className: 'toolbar'

  initialize: ->
    @initiative = new View.InitiativeBoard

  events:
    'click button.initiative': 'showInitiative'

  render: ->
    @$el.html renderTemplate('toolbar/show')
    this

  showInitiative: (event) ->
    if !@inDom(@initiative)
      $('body').append @initiative.render().el
      forceShow = true

    if forceShow || !@shown(@initiative)
      button = $(event.target)
      toolbar_top = parseInt @$el.css('top') 
      button_pos = button.position()
      width = button.outerWidth()

      @initiative.$el.show().offset
        left: button_pos.left + width + 10
        top: toolbar_top + button_pos.top

  inDom: (view) ->
    view.$el.closest('html').size() > 0

  shown: (view) ->
    view.$el.is ':visible'

