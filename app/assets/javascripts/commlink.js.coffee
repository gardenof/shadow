#=require view
#=require named_routes
#=require data_sync

class window.Commlink extends Backbone.Model
  model_name: 'commlink'

  collection: new (Backbone.Collection.extend(
    model: Commlink
    url: NamedRoutes.helpers.commlinks_path
    ))

Commlink.collection = Commlink::collection
DataSync.register 'Commlink', Commlink.collection
View.Commlink = {}

class View.Commlink.Show extends Backbone.View
  className: "commlink"

  render: ->
    this.$el.html renderTemplate(
      'commlinks/_show',
      commlink: this.model)

    $('.commlink').html(this.$el)

    $('.commlink input.active').iphoneStyle(
      {
        onChange: this.updateActive,
        checkedLabel: 'ACTIVE',
        uncheckedLabel: 'HIDDEN'
      })

  updateActive: =>
    commlink = this.$ 'input.active'
    this.model.save active: commlink.prop('checked')
