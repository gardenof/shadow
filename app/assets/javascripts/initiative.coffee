#=require view
 
class Initiative extends Backbone.Model
  initialize: ->
    @participants = new Backbone.Collection
    @participants.on 'add', (a...) => @trigger('add', a...)
    @participants.on 'remove', (a...) => @trigger('remove', a...)

  addCharacter: (character) ->
    @addParticipant new Participant
      name: character.get('name')
      pool: character.get('surprise')

  addParticipant: (participant) ->
    @participants.add participant

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

  reRoll: ->
    pool = new Pool parseInt(@get('pool'))
    pool.roll()
    @set
      rolls: pool.rolls?.join(", ")
      score: pool.hits()

class View.InitiativeBoard extends Backbone.View
  className: 'initiative-board'

  events:
    'click .close-button': 'close'
    'click .add-setting-characters': 'addSettingCharacters'
    'click .add-new-participant': 'addNewParticipant'
    'click .re-roll-all': 'reRollAll'

  initialize: ->
    @model = new Initiative
    @model.on 'add', @addRow
    @$el.draggable()
    @rows = []

  render: ->
    @$el.html renderTemplate('initiative/show', model: @model)
    this

  close: ->
    @$el.hide()

  addNewParticipant: ->
    @model.addParticipant new Participant

  addSettingCharacters: ->
    setting_id = @$(':input[name="initiative[game_setting_id]"]').val()
    setting = GameSetting.collection.get setting_id

    if setting
      for character in setting.characters()
        @model.addCharacter character

  addRow: (participant) =>
    view = new View.InitiativeRow model: participant
    @rows.push view
    @$('.characters').append view.render().el

  rowsInInitiativeOrder: ->
    _.sortBy @rows, (row) ->
      score = row.model.get "score"

      if score
        -score
      else
        0

  reOrderRows: ->
    for row in @rowsInInitiativeOrder()
      @$('.characters').append row.el

  reRollAll: ->
    @model.reRollAll()
    @reOrderRows()

class View.InitiativeRow extends Backbone.View
  tagName: 'tr'

  events:
    'click .edit-button': 'edit'
    'click .cancel-button': 'noEdit'
    'change input': 'update'
    'keyUp input': 'update'

  initialize: ->
    @model.on 'change', @render
    @_edit = false

  render: =>
    if @_edit
      @$el.html renderTemplate('initiative/row_edit', model: @model)
    else
      @$el.html renderTemplate('initiative/row', model: @model)

    this

  noEdit: (event) ->
    event.stopPropagation()
    @_edit = false
    @render()

  edit: (event) ->
    event.stopPropagation()
    @_edit = true
    @render()

  update: ->
    @model.set
      name: @$('input[name="name"]').val()
      pool: parseInt(@$('input[name="pool"]').val())
