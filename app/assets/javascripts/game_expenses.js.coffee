class window.GameExpense extends Backbone.Model
  total: ->
    if this.get("pay_cycle")
      this.get("price") / 12
    else
      this.get("price")

  annualTotal: ->
    this.total() * 12


GameExpense.collection = new (Backbone.Collection.extend(
  model: GameExpense
  total: ->
    _.foldl this.models, ((t,expense) -> t + expense.total()), 0
  ))

