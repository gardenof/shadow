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

  describe "link navigation in workspace", ->
    beforeEach ->
      Backbone.history.start silent: true

    afterEach ->
      Backbone.history.stop silent: true
      window.location.hash = ''

    it "emits routing events", ->
      setFixtures "<div class='workspace'><a href='/characters'></a></div>"
      workspace = new Workspace elementSelector: '.workspace'
      handler = jasmine.createSpy('route handler')
      workspace.on "route:characters.index", handler

      $(".workspace a").trigger 'click'
      expect(handler).toHaveBeenCalled()



