$(document).on 'page:change', ->
  $("[data-add-comment]").on 'click', ->
    parentComment = $(this).closest('.Entry-wrapper')
    addCommentBox = parentComment.find(".CommentBox")

    # FIXME: use css class to do this
    addCommentBox.addClass('is-active')

  $(".Button--cancel").on 'click', (e) ->
    e.preventDefault()
    $(this).parents(".CommentBox").removeClass('is-active')

  $('a[data-minimize]').click ->
    thisComment = $(this).closest('.comment')
    wrapper = thisComment.next('.comment-commentsWrapper')
    if wrapper.is(':visible')
      wrapper.slideUp()
      $(this).find('.metaInfo-icon').html("<i class='fa fa-plus'></i>")
    else
      wrapper.slideDown()
      $(this).find('.metaInfo-icon').html("<i class='fa fa-minus'></i>")