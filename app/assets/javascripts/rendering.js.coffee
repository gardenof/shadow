window.Rendering =
  helpers: {}
  renderTemplate: (view, assigns) ->
    all_assigns = _.foldl _.values(Rendering.helpers),
                          _.extend,
                          {}

    JST["templates/#{view}"](_.extend(all_assigns, assigns))

Rendering.helpers.renderTemplate = Rendering.renderTemplate
window.renderTemplate = Rendering.renderTemplate
