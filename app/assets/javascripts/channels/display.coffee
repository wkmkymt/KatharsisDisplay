App.display = App.cable.subscriptions.create "DisplayChannel",
  connected: ->
    console.log("Display Channnel is connected!")
    return

  disconnected: ->
    return

  received: (data) ->
    if data.code == 'checkin'
      addUser(data.user)
      setChangeFlag()

    if data.code == 'checkout'
      removeUser(data.user)
      setChangeFlag()

    return