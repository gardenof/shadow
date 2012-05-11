(function() {

  describe('Workspace', function() {
    return describe('show', function() {
      beforeEach(function() {
        return setFixtures("<div class='workspace'></div>");
      });
      it('renders the page and adds to to the dom', function() {
        var view, workspace;
        workspace = new Workspace({
          elementSelector: '.workspace'
        });
        view = new Backbone.View;
        view.render = function() {
          this.$el.html("foopants");
          return this;
        };
        workspace.show(view);
        return expect($('.workspace')).toHaveText("foopants");
      });
      return it('emits a live event for elements', function() {
        var element, handler, view, workspace;
        workspace = new Workspace({
          elementSelector: '.workspace'
        });
        view = new Backbone.View;
        view.$el.html('<div></div>');
        element = view.$('div');
        handler = jasmine.createSpy('live handler');
        $(document).on('workspace:live', element, handler);
        workspace.show(view);
        $(document).off('workspace:live', element, handler);
        expect(handler).toHaveBeenCalled();
        expect(handler.argsForCall[0][0].target).toBe(element[0]);
        return expect(handler.argsForCall[0][1]).toBe(workspace);
      });
    });
  });

}).call(this);
