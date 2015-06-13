$(document).on 'page:change', ->
  form = $('form')
  submitButton = form.find('.Button--submit')
  submitButton.on 'click', (e) =>
    e.preventDefault()
    form.submit()
