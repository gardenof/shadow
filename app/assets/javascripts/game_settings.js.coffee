#= require named_routes
#
class window.GameSetting extends Backbone.Model
  model_name: 'game_setting'

  collection: new (Backbone.Collection.extend(
    url: NamedRoutes.helpers.game_settings_path
    model: GameSetting
    ))

GameSetting.collection = GameSetting::collection

