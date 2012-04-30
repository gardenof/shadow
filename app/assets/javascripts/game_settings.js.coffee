#= require named_routes
#
class window.GameSetting extends Backbone.Model

GameSetting.collection = new (Backbone.Collection.extend(
  url: NamedRoutes.helpers.game_settings
  model: GameSetting
  ))

