class DataSync
  constructor: ->
    @syncStatus = {}

  collections: ['Character', 'GameAsset', 'GameExpense', 'GameSetting', 'Commlink']

  checkFrequency: 1000
  syncFrequency: 20 * 1000
  failureBackoffFactor: 3

  start: (initial) ->
    @reset collection, initial[collection] for collection in @collections
    @syncLoop()

  stop: ->
    @stopSync = true

  reset: (collectionName, models) ->
    if models
      window[collectionName].collection.reset models
    else
      console?.log? "No initial models provided for #{collectionName}"

    @syncCompleted collectionName

  fetch: (collectionName) ->
    @syncStarted collectionName
    window[collectionName].collection.fetch(
      success: => @syncCompleted collectionName
      error: => @syncFailed collectionName
    )

  syncLoop: =>
    if @stopSync
      @stopSync = false
      return

    name = @nominateNextSync()
    @fetch(name) if name
    setTimeout @syncLoop, @checkFrequency

  nominateNextSync: ->
    now = new Date()
    completedFreq = @syncFrequency
    failedFreq = completedFreq * @failureBackoffFactor

    eligibleStatus = _.find @syncStatus,
                            (sync) ->
                              (sync.status == 'completed' && (now - sync.at > completedFreq)) ||
                              (sync.status == 'failed' && (now - sync.at > failedFreq))

    eligibleStatus?.name

  syncStarted: (collectionName) ->
    @syncStatus[collectionName] = { status: 'started', at: new Date(), name: collectionName }

  syncCompleted: (collectionName) ->
    @syncStatus[collectionName] = { status: 'completed', at: new Date(), name: collectionName }

  syncFailed: (collectionName) ->
    console?.log? "Sync of #{collectionName} failed at #{new Date()}"

    @syncStatus[collectionName] = { status: 'failed', at: new Date(), name: collectionName }

window.DataSync = new DataSync()

