class Workspace extends Backbone.Router
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

window.ShadowWorkspace = new Workspace

$('a').live 'click', (event) ->
  $this = $(this)
  method = $this.data('method')
  href = $this.attr('href')

  if _.isUndefined(method) && !(/^([a-zA-Z]+):\/\//.test(href))
    r = ShadowWorkspace.navigate href, trigger: true
    event.preventDefault()


$ -> Backbone.history.start pushState: true, silent: true

