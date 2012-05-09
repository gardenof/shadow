#= require named_routes
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
View.GameSetting = {}

class View.GameSetting.Index extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/index',
      game_settings: GameSetting.collection.models)

    $('body').html(this.$el)

class View.GameSetting.Show extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/show',
      game_setting: this.model)

    $('body').html(this.$el)

class View.GameSetting.New extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/new',
      game_setting: this.model
      errors: this.options.errors)

    $('body').html this.$el

class View.GameSetting.Edit extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/edit',
      game_setting: this.model
      errors: this.options.errors)

    $('body').html this.$el

class View.GameSetting.GmView extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_settings/gmview',
      game_setting: this.model)

    $('body').html(this.$el)
