#= require named_routes
#
class window.GameAsset extends Backbone.Model
  model_name: 'game_asset'

  collection: new (Backbone.Collection.extend(
    url: NamedRoutes.helpers.game_assets_path
    model: GameAsset
    total: ->
      _.foldl this.models, ((t,asset) -> t + asset.total()), 0
    ))

  total: ->
    price = this.get "price"
    amount = this.get "amount"

    if price && amount
      price * amount

  streetValue: ->
    this.total() * 0.8

GameAsset.collection = GameAsset::collection

