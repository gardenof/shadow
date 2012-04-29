window.Rendering =
  helpers:
    renderWithLayout: (layoutView, contentView, assigns) ->
      content = renderTemplate contentView, assigns

      layout_assigns = _.extend {},
                                assigns,
                                content_for:
                                  layout: content

      renderTemplate 'layouts/' + layoutView,
                      _.extend({}, assigns, layout_assigns)

    renderTemplate: (view, assigns) ->
      all_assigns = _.foldl _.values(Rendering.helpers),
                            _.extend,
                            {}

      JST["templates/#{view}"](_.extend(all_assigns, assigns))

_.extend Rendering, Rendering.helpers
_.extend window, Rendering.helpers

