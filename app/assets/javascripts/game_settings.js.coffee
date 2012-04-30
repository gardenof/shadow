#= require named_routes
#
class window.GameSetting extends Backbone.Model
  collection: new (Backbone.Collection.extend(
    url: NamedRoutes.helpers.game_settings_path
    model: GameSetting
    ))

GameSetting.collection = GameSetting::collection

