$(document).on 'page:change', ->
  console.log "voter.js loaded"

  handleSend = (e, data, status, xhr) ->
    console.log "change vote event send."

  handleSuccess = (e, data, status, xhr) ->
    console.log "change vote event success."
    console.log $(e.currentTarget).closest(".voter")

  $('.voter__vote').on 'ajax:success', (e, data, status, xhr) ->
    handleSuccess(e, data, status, xhr)