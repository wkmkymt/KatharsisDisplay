App.display = App.cable.subscriptions.create "DisplayChannel",
  connected: ->
    return

  disconnected: ->
    return

  received: (data) ->
    console.log(data)
    li = document.createElement('li')
    li.textContent = data.name
    document.getElementById('prof').appendChild(li)
    return