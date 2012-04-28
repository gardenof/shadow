# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class window.GameAsset extends Backbone.Model
  total: ->
    price = this.get "price"
    amount = this.get "amount"

    if price && amount
      price * amount

GameAsset.collection = new (Backbone.Collection.extend(
  model: GameAsset
  total: ->
    _.foldl this.models, ((t,asset) -> t + asset.total()), 0
  ))

