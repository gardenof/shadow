class DataSync
  constructor: ->
    @syncs = []

  checkFrequency: 1000
  syncFrequency: 20 * 1000
  failureBackoffFactor: 3

  register: (name, collection) ->
    @syncs.push new CollectionSync(name, collection)

  start: (initial) ->
    sync.reset initial[sync.name] for sync in @syncs
    @syncLoop()

  stop: ->
    @stopSync = true

  syncLoop: =>
    if @stopSync
      @stopSync = false
      return

    sync = @nominateNextSync()
    sync?.fetch()
    setTimeout @syncLoop, @checkFrequency

  nominateNextSync: ->
    now = new Date()
    completedFreq = @syncFrequency
    failedFreq = completedFreq * @failureBackoffFactor

    _.find @syncs, (sync) -> sync.isEligibleAt now, completedFreq, failedFreq

class CollectionSync
  constructor: (@name, @collection) ->
    @status = 'never'
    @at = new Date()

  reset: (models) ->
    if models
      @collection.reset models
    else
      console?.log? "No initial models provided for #{collectionName}"

    @syncCompleted()

  fetch: ->
    @syncStarted()
    @collection.fetch
      success: => @syncCompleted()
      error: => @syncFailed()

  isEligibleAt: (now, completedFreq, failedFreq) ->
    (@status == 'completed' && (now - @at > completedFreq)) ||
    (@status == 'failed' && (now - @at > failedFreq))

  updateStatus: (status) ->
    @status = status
    @at = new Date()

  syncStarted: ->
    @updateStatus 'started'

  syncCompleted: ->
    @updateStatus 'completed'

  syncFailed: ->
    @updateStatus 'failed'
    console?.log? "Sync of #{@name} failed at #{@at}"

window.DataSync = new DataSync()

