#= required named_routes
#
class window.GameExpense extends Backbone.Model
  model_name: 'game_expense'

  collection: new (Backbone.Collection.extend(
    url: NamedRoutes.helpers.game_expenses_path
    model: GameExpense
    total: ->
      _.foldl this.models, ((t,expense) -> t + expense.total()), 0
    ))

  total: ->
    if this.get("pay_cycle")
      this.get("price") / 12
    else
      this.get("price")

  annualTotal: ->
    this.total() * 12

GameExpense.collection = GameExpense::collection
View.GameExpense = {}

class View.GameExpense.Index extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_expenses/index',
      game_expenses: GameExpense.collection.models)

    $('body').html(this.$el)

class View.GameExpense.Show extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_expenses/show',
      expn: this.model
      errors: this.options.errors)

    $('body').html(this.$el)

class View.GameExpense.New extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_expenses/new',
      expn: this.model
      errors: this.options.errors
      character: this.options.character
    )

    $('body').html(this.$el)

ShadowWorkspace.on 'route:game_expenses.new', (character_id) ->
  character = Character.collection.get character_id
  expense = new GameExpense character_id: character_id,
                            amount: 1

  new View.GameExpense.New({model: expense, character: character}).render()


class View.GameExpense.Edit extends Backbone.View
  render: ->
    this.$el.html renderWithLayout(
      'application',
      'game_expenses/edit',
      expn: this.model
      errors: this.options.errors
    )

    $('body').html(this.$el)

ShadowWorkspace.on 'route:game_expenses.edit', (id) ->
  expense = GameExpense.collection.get id
  new View.GameExpense.Edit({model: expense}).render()

