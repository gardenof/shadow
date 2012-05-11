describe 'Workspace', ->
  describe 'show', ->
    beforeEach ->
      setFixtures "<div class='workspace'></div>"

    it 'renders the page and adds to to the dom', ->
      workspace = new Workspace elementSelector: '.workspace'
      view = new Backbone.View
      view.render = ->
        @$el.html("foopants")
        this

      workspace.show view
      expect($('.workspace')).toHaveText("foopants")

    it 'emits a live event for elements', ->
      workspace = new Workspace elementSelector: '.workspace'
      view = new Backbone.View
      view.$el.html('<div></div>')
      element = view.$('div')
      handler = jasmine.createSpy('live handler')

      $(document).on 'workspace:live', element, handler
      workspace.show view
      $(document).off 'workspace:live', element, handler

      expect(handler).toHaveBeenCalled()
      expect(handler.argsForCall[0][0].target).toBe(element[0])
      expect(handler.argsForCall[0][1]).toBe(workspace)


