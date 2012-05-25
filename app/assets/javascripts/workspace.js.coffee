class window.Workspace extends Backbone.Router
  constructor: (@options) ->
    super(@options)
    @_tryBindingLinkNavigation()

  $el: ->
    $(@options.elementSelector)

  routes:
    "": "characters.index"
    "characters": "characters.index"
    "characters/new": "characters.new"
    "characters/:id": "characters.show"
    "characters/:id/edit": "characters.edit"

    "game_assets/new/:character_id": "game_assets.new"
    "game_assets/:id/edit": "game_assets.edit"

    "game_expenses/new/:character_id": "game_expenses.new"
    "game_expenses/:id/edit": "game_expenses.edit"

    "game_settings": "game_settings.index"
    "game_settings/new": "game_settings.new"
    "game_settings/:id": "game_settings.show"
    "game_settings/:id/edit": "game_settings.edit"
    "game_settings/:id/gmview": "game_settings.gmview"

  show: (view) ->
    @_tryBindingLinkNavigation()
    @$el().html view.render().el
    view.$('*').trigger 'workspace:live', this

  _tryBindingLinkNavigation: ->
    if @$el().size() > 0
      @_bindLinkNavigation()
      @_tryBindingLinkNavigation = -> false

  _bindLinkNavigation: ->
    _this = this
    @$el().on 'click', 'a', (event) ->
      $this = $(this)
      method = $this.data('method')
      href = $this.attr('href')

      if _.isUndefined(method) && !(/^([a-zA-Z]+):\/\//.test(href))
        _this.navigate href, trigger: true
        event.preventDefault()

window.ShadowWorkspace = new Workspace elementSelector: '#workspace'

