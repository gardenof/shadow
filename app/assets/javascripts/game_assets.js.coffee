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

View.GameAsset = {}

class View.GameAsset.Table extends Backbone.View
  tagName: "table"
  className: "gear assets"

  render: ->
    this.$el.html renderTemplate(
      'game_assets/_table',
      character: this.model)

    $('.game-assets-table').html(this.$el)

    (new View.GameAsset.Row({model: asset}).render()) for asset in this.model.assets();

class View.GameAsset.Row extends Backbone.View
  tagName: "tr"

  events:
    'change input.equipped': 'updateEquipped'

  render: ->
    this.$el.html renderTemplate(
      'game_assets/_row',
      asset: this.model)
    $('tbody.assets').append(this.$el)

  updateEquipped: =>
    checkbox = this.$ 'input.equipped'
    this.model.save equipped: checkbox.prop('checked')
