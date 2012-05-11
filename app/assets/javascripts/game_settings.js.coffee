#=require named_routes
#=require workspace
#=require data_sync
#
class window.GameSetting extends Backbone.Model
  model_name: 'game_setting'

  collection: new (Backbone.Collection.extend(
    url: NamedRoutes.helpers.game_settings_path
    model: GameSetting
    ))

  characters: ->
    Character.collection.where game_setting_id: this.id

GameSetting.collection = GameSetting::collection
DataSync.register 'GameSetting', GameSetting.collection
View.GameSetting = {}

class View.GameSetting.Index extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/index',
      game_settings: GameSetting.collection.models)

    this


ShadowWorkspace.on "route:game_settings.index", ->
  ShadowWorkspace.show new View.GameSetting.Index()

class View.GameSetting.Show extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/show',
      game_setting: this.model)

    this

ShadowWorkspace.on "route:game_settings.show", (id) ->
  game_setting = GameSetting.collection.get id
  ShadowWorkspace.show new View.GameSetting.Show(model: game_setting)

class View.GameSetting.New extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/new',
      game_setting: this.model
      errors: this.options.errors)

    this

ShadowWorkspace.on "route:game_settings.new", ->
  game_setting = new GameSetting
  ShadowWorkspace.show new View.GameSetting.New(model: game_setting)

class View.GameSetting.Edit extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/edit',
      game_setting: this.model
      errors: this.options.errors)

    this

ShadowWorkspace.on "route:game_settings.edit", (id) ->
  game_setting = GameSetting.collection.get id
  ShadowWorkspace.show new View.GameSetting.Edit(model: game_setting)

class View.GameSetting.GmView extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/gmview',
      game_setting: this.model)

    this

ShadowWorkspace.on "route:game_settings.gmview", (id) ->
  setting = GameSetting.collection.get id
  ShadowWorkspace.show new View.GameSetting.GmView(model: setting)

