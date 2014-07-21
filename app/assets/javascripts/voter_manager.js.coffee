(($, window, document) ->

  $.widget "bronko.voterManager",

    _create: ->

      @total = @element.find('.voter__total')
      @upvote = @element.find('.voter__vote--up')
      @downvote = @element.find('.voter__vote--down')
      @reset = @element.find('.voter__vote--reset')
      @votableId = @element.data('id')

      @reset.addClass('is-hidden')

      @_on @upvote,
        'click': (event) ->
          event.preventDefault()
          console.log 'click event upvote: ', @votableId

          if @upvote.hasClass('is-current')
            @upvote.removeClass('is-current')
            @_resetVote()
          else
            @downvote.removeClass('is-current')
            @upvote.addClass('is-current')
            @_makeAjax(true)

      @_on @downvote,
        'click': (event) ->
          event.preventDefault()
          console.log 'click event downvote: ', @votableId

          if @downvote.hasClass('is-current')
            @downvote.removeClass('is-current')
            @_resetVote()
          else
            @upvote.removeClass('is-current')
            @downvote.addClass('is-current')
            @_makeAjax(false)

    _makeAjax: (isUpvote) ->
      $.ajax
        url: "/popmeters/" + @votableId + "?is_upvote=" + isUpvote,
        dataType: 'script',
        type: "PATCH",
        done: ( xhr ) ->
          console.log "done ajax: ", isUpvote, @votableId
        success: ( data, textStatus, jqXHR ) ->
          console.log "success ajax: ", isUpvote, @votableId
        error: ( jqXHR, textStatus, errorThrown ) ->
          console.log textStatus, errorThrown

    _resetVote: ->
      $.ajax
        url: "/popmeters/" + @votableId,
        dataType: 'script',
        type: "DELETE",
        done: ( xhr ) =>
          console.log "done ajax: ", isUpvote, @votableId
        success: ( data, textStatus, jqXHR ) =>
          console.log "success ajax: ", isUpvote, @votableId
        error: ( jqXHR, textStatus, errorThrown ) =>
          console.log textStatus, errorThrown

    # Destroy an instantiated plugin and clean up
    # modifications the widget has made to the DOM
    destroy: ->

      # this.element.removeStuff();
      # For UI 1.8, destroy must be invoked from the
      # base widget
      $.Widget::destroy.call @
      # For UI 1.9, define _destroy instead and don't
      # worry about
      # calling the base widget

      # For UI 1.8, _setOption must be manually invoked
      # from the base widget
      $.Widget::_setOption.apply @, arguments_
      # For UI 1.9 the _super method can be used instead
      # this._super( "_setOption", key, value );
      return
  return
) jQuery, window, document