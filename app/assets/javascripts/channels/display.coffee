App.display = App.cable.subscriptions.create "DisplayChannel",
  connected: ->
    console.log("Display Channnel is connected!")
    return

  disconnected: ->
    return

  received: (data) ->
    if data.code == 'checkin'
      addProf(data.user, data.tags)

    if data.code == 'checkout'
      removeProf(data.userid)

    return