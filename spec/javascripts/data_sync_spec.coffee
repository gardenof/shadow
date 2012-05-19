describe "DataSync", ->
  describe "CollectionSync", ->
    beforeEach ->
      jasmine.Ajax.useMock()

      @coll = new Backbone.Collection
      @coll.url = '/foo'
      @coll.model = Backbone.Model

      @sync = new CollectionSync 'foo', @coll

    describe "reset", ->
      it "puts the models into the collection", ->
        @sync.reset [{id: "foo"}, {id: "bar"}]
        expect(@coll.models.length).toBe(2)


    describe "fetch", ->
      it "resets the contents of the collection", ->
        @sync.fetch()

        request = mostRecentAjaxRequest()
        request.response Fixtures.FooAndBar

        expect(@coll.models.length).toBe(2)

      it "generate add events for models not in the collection", ->
        onAdd = jasmine.createSpy 'onAdd'
        @coll.on 'add', onAdd
        @sync.fetch()

        request = mostRecentAjaxRequest()
        request.response Fixtures.FooAndBar

        expect(onAdd.callCount).toBe(2)

      it "generates change events for models already in the collection", ->
        @coll.add id: "foo"

        onChange = jasmine.createSpy 'onChange'
        @coll.get('foo').on 'change', onChange

        @sync.fetch()

        request = mostRecentAjaxRequest()
        request.response Fixtures.FooChanged

        expect(onChange).toHaveBeenCalled()

      it "removes models that are no longer in the collection", ->
        collRemove = jasmine.createSpy 'collRemove'
        modelRemove = jasmine.createSpy 'modelRemove'
        @coll.add id: "foo"

        @coll.on 'remove', collRemove
        @coll.get('foo').on('remove', modelRemove)

        @sync.fetch()

        request = mostRecentAjaxRequest()
        request.response Fixtures.Empty

        expect(@coll.models.length).toBe(0)
        expect(collRemove).toHaveBeenCalled()
        expect(modelRemove).toHaveBeenCalled()


Fixtures =
  FooAndBar:
    status: 200
    responseText: """
                  [{"id": "foo"}, {"id": "bar"}]
                  """

  FooChanged:
    status: 200
    responseText: """
                  [{"id": "foo", "name": "Foo"}, {"id": "bar"}]
                  """

  Empty:
    status: 200
    responseText: "[]"
