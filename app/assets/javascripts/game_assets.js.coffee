#= require named_routes
#
class window.GameAsset extends Backbone.Model
  model_name: 'game_asset'


  collection: new (Backbone.Collection.extend(
    model: GameAsset
    url: NamedRoutes.helpers.game_assets_path
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

ShadowWorkspace.on 'route:game_assets.edit', (id) ->
  asset = GameAsset.collection.get id
  new View.GameAsset.Edit({model: asset}).render()

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

ShadowWorkspace.on 'route:game_assets.new', (character_id) ->
  character = Character.collection.get character_id
  asset = new GameAsset character_id: character_id,
                        amount: 1

  new View.GameAsset.New({model: asset, character: character}).render()

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
