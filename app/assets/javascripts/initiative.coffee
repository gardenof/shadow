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
    @resetInitiative()

  resetInitiative: ->
    for p in @participants.models
      p.set "activePass", null

    @inInitiativeOrder()[0]?.set "activePass", 1

  nextInitiative: ->
    inOrder = @inInitiativeOrder()
    active = _.find inOrder, (m) -> m.get("activePass")

    if active
      currentPass = active.get "activePass"
      active.set "activePass", null
      index = _.indexOf inOrder, active

      if index < (inOrder.length - 1)
        inOrder[index + 1]?.set "activePass", currentPass
      else
        inOrder[0]?.set "activePass", (currentPass % 4) + 1


  inInitiativeOrder: ->
    _.sortBy @participants.models, (model) ->
      model.initiativeSortOrder()

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

  passClass: (passN) ->
    if @get('activePass') == passN
      'active'
    else
      ''

  initiativeSortOrder: ->
    score = @get "score"

    if score
      -score
    else
      0

class View.InitiativeBoard extends Backbone.View
  className: 'initiative-board'

  events:
    'click .close-button': 'close'
    'click .add-setting-characters': 'addSettingCharacters'
    'click .add-new-participant': 'addNewParticipant'
    'click .re-roll-all': 'reRollAll'
    'click .next-initiative': 'nextInitiative'

    'mousedown': 'startDrag'
    'mouseup': 'stopDrag'

  initialize: ->
    @model = new Initiative
    @model.on 'add', @addRow
    @model.on 'remove', @removeRow
    $(document).mousemove @drag
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

  removeRow: (participant) =>
    @rows = _.reject @rows, (row) ->
      row.model == participant

  rowsInInitiativeOrder: ->
    _.sortBy @rows, (row) ->
      row.model.initiativeSortOrder()

  reOrderRows: ->
    for row in @rowsInInitiativeOrder()
      @$('.characters').append row.el

  reRollAll: ->
    @model.reRollAll()
    @reOrderRows()

  nextInitiative: ->
    @model.nextInitiative()

  startDrag: (event) ->
    if $(event.target).is(':input, button, a, :submit')
      return

    @_dragging = true
    @_dragOrigin = { x: event.pageX, y: event.pageY }
    @_elOrigin = 
      x: parseInt @$el.css("left")
      y: parseInt @$el.css("top")

    event.stopPropagation()
    event.preventDefault()

  stopDrag: (event) ->
    if @_dragging
      @_dragging = false
      @_dragOrigin = null
      @_elOrigin = null

      event.stopPropagation()
      event.preventDefault()

  drag: (event) =>
    if @_dragging
      event.stopPropagation()
      event.preventDefault()
      @$el.css
        top: @_elOrigin.y + event.pageY - @_dragOrigin.y
        left: @_elOrigin.x + event.pageX - @_dragOrigin.x


class View.InitiativeRow extends Backbone.View
  tagName: 'tr'

  events:
    'click .edit-button': 'edit'
    'click .done-button': 'done'
    'click .remove-button': 'destroy'
    'change input': 'update'
    'keyUp input': 'update'

  initialize: ->
    @model.on 'change', @render
    @model.on 'destroy', @destroyed
    @_edit = false

  render: =>
    if @_edit
      @$el.html renderTemplate('initiative/row_edit', model: @model)
    else
      @$el.html renderTemplate('initiative/row', model: @model)

    this

  destroyed: =>
    @remove()

  done: (event) ->
    event.stopPropagation()
    @_edit = false
    @render()

  destroy: (event) ->
    event.stopPropagation()
    @model.destroy()

  edit: (event) ->
    event.stopPropagation()
    @_edit = true
    @render()

  update: ->
    @model.set
      name: @$('input[name="name"]').val()
      pool: parseInt(@$('input[name="pool"]').val())
