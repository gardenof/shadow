#=require view
 
class Initiative extends Backbone.Model
  initialize: ->
    @participants = new Backbone.Collection
    @participants.on 'add', (a...) => @trigger('add', a...)
    @participants.on 'remove', (a...) => @trigger('remove', a...)

  addCharacter: (character) ->
    @participants.add new Participant
      name: character.get('name')
      pool: character.get('surprise')

  reRollAll: ->
    p.reRoll() for p in @participants.models

  model_name: 'initiative'

d6 = -> Math.floor(Math.random() * 5) + 1

class Pool
  constructor: (@size) ->

  roll: ->
    if @size
      @rolls = (d6() for n in [1..@size])

  hits: ->
    if @rolls
      @size + _.filter(@rolls, (x) -> x >= 5).length

class Participant extends Backbone.Model
  initialize: (a...) ->
    super a...
    @_pool = new Pool parseInt(@get('pool'))

  reRoll: ->
    @_pool.roll()
    @set
      rolls: @_pool.rolls?.join(", ")
      score: @_pool.hits()

class View.InitiativeBoard extends Backbone.View
  className: 'initiative-board'

  events:
    'click .close-button': 'close'
    'click .add-setting-characters': 'addSettingCharacters'
    'click .re-roll-all': 'reRollAll'

  initialize: ->
    @model = new Initiative
    @model.on 'add', @addRow
    @$el.draggable()

  render: ->
    @$el.html renderTemplate('initiative/show', model: @model)
    this

  close: ->
    @$el.hide()

  addSettingCharacters: ->
    setting_id = @$(':input[name="initiative[game_setting_id]"]').val()
    setting = GameSetting.collection.get setting_id

    if setting
      for character in setting.characters()
        @model.addCharacter character

  addRow: (participant) =>
    view = new View.InitiativeRow model: participant
    @$('.characters').append view.render().el

  reRollAll: ->
    @model.reRollAll()

class View.InitiativeRow extends Backbone.View
  tagName: 'tr'

  initialize: ->
    @model.on 'change', @render

  render: =>
    @$el.html renderTemplate('initiative/row', model: @model)
    this

