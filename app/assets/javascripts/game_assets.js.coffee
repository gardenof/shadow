#= require named_routes
#
class window.GameAsset extends Backbone.Model
  model_name: 'game_asset'

  url: -> 
    if this.isNew() 
      NamedRoutes.helpers.character_game_assets_path(this.get("character_id"))
    else
      NamedRoutes.helpers.character_game_asset_path(this.get("character_id"), this)

  collection: new (Backbone.Collection.extend(
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

class View.GameAsset.Index extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_assets/index',
      game_assets: GameAsset.collection.models)

    $('body').html(this.$el)

class View.GameAsset.Show extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_assets/show',
      asset: this.model
      errors: this.options.errors)

    $('body').html(this.$el)

class View.GameAsset.Edit extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_assets/edit',
      asset: this.model
      errors: this.options.errors
    )

    $('body').html(this.$el)

class View.GameAsset.New extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_assets/new',
      asset: this.model
      errors: this.options.errors
      character: this.options.character
    )

    $('body').html(this.$el)
