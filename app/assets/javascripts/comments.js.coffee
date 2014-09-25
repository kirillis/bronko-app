$(document).on 'page:change', ->
  $("a[data-add-comment]").on 'click', ->
    parentComment = $(this).parents('.comment').first()
    addCommentBox = parentComment.find(".addCommentBox")

    # FIXME: use css class to do this
    addCommentBox.addClass('is-visible')

  $("a[data-cancel-comment]").on 'click', ->
    $(this).parents(".addCommentBox").removeClass('is-visible')

  $('a[data-minimize]').click ->
    thisComment = $(this).closest('.comment')
    wrapper = thisComment.next('.comment-commentsWrapper')
    if wrapper.is(':visible')
      wrapper.slideUp()
      $(this).find('.metaInfo-icon').html("<i class='fa fa-plus'></i>")
    else
      wrapper.slideDown()
      $(this).find('.metaInfo-icon').html("<i class='fa fa-minus'></i>")