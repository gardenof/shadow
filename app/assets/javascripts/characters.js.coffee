#=require view
#=require workspace
#=require named_routes
#=require data_sync

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
DataSync.register 'Character', Character.collection

View.Character = {}

class View.Character.Index extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'characters/index',
      characters: Character.collection.models)
    this

ShadowWorkspace.on 'route:characters.index', ->
  ShadowWorkspace.show new View.Character.Index()

class View.Character.Show extends Backbone.View
  render: ->
    @$el.html renderWithLayout(
      'application',
      'characters/show',
      character: this.model)

    @$('.commlink').html(
      new View.Commlink.Show(model: @model.commlink()).render().el
    )

    @$('.game-assets-table').html(
      new View.GameAsset.Table(model: @model).render().el
    )

    this

ShadowWorkspace.on 'route:characters.show', (id) ->
  character = Character.collection.get parseInt(id)
  ShadowWorkspace.show new View.Character.Show(model: character)

class View.Character.Edit extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'characters/edit',
      character: this.model
      errors: this.options.errors
    )
    this


ShadowWorkspace.on 'route:characters.edit', (id) ->
  character = Character.collection.get parseInt(id)
  ShadowWorkspace.show new View.Character.Edit(model: character)

class View.Character.New extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'characters/new',
      character: this.model
      errors: this.options.errors
    )
    this

ShadowWorkspace.on 'route:characters.new', (id) ->
  character = new Character()
  ShadowWorkspace.show new View.Character.New(model: character)

