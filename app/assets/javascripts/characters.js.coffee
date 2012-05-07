#=require view
#=require named_routes

class window.Character extends Backbone.Model
  model_name: 'character'

  collection: new (Backbone.Collection.extend(
    model: Character
    url: NamedRoutes.helpers.characters_path
    ))

  assets: ->
    GameAsset.collection.where character_id: this.id

  assetTotal: ->
    _.foldl this.assets(),
            (total, asset) -> total + asset.total(),
            0

  commlink: ->
    link = (Commlink.collection.where character_id: this.id)[0]

    unless link
      link = new Commlink({character_id: this.id})
      Commlink.collection.add(link)
    link

  expenses: ->
    GameExpense.collection.where character_id: this.id

  expenseTotal: ->
    _.foldl this.expenses(),
            (total, expense) -> total + expense.total(),
            0

  equippedAssets: ->
     _.filter this.assets(), (a) -> a.get "equipped"

  legalStatus: ->
     _.foldl this.equippedAssets(),
             ((legality, asset) ->
               assetLegality = asset.get "legality"

               if legality == "Public"
                 assetLegality
               else if assetLegality == "Forbidden"
                 "Forbidden"
               else
                 legality),

             "Public"

Character.collection = Character::collection
View.Character = {}

class View.Character.Index extends Backbone.View
  initialize: ->
    Character.collection.bind 'change', this.render, this

  render: ->
    this.$el.html renderWithLayout(
      'application',
      'characters/index',
      characters: Character.collection.models)

    $('body').html(this.$el)


class View.Character.Show extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'characters/show',
      character: this.model)

    $('body').html(this.$el)

    new View.Commlink.Show({model: this.model.commlink()}).render()
    new View.GameAsset.Table({model: this.model}).render()

class View.Character.Edit extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'characters/edit',
      character: this.model
      errors: this.options.errors
    )

    $('body').html(this.$el)

class View.Character.New extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'characters/new',
      character: this.model
      errors: this.options.errors
    )

    $('body').html(this.$el)
