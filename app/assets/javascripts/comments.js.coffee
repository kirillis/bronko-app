# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  console.log "comments.js loaded"
  $("a[data-add-comment]").on 'click', ->
    console.log "click!"
    form = $(this).next(".comment__add-box")

    # FIXME: use css class to do this
    form.fadeIn()

  $("a[data-cancel-comment]").on 'click', ->
    $(this).parents(".comment__add-box").fadeOut()
