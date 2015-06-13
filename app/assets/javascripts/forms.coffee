$(document).on 'page:change', ->
  form = $('form')
  submitButton = $('.Button--submit')
  submitButton.on 'click', (e) =>
    e.preventDefault()
    $(e.currentTarget).closest('form').submit();
