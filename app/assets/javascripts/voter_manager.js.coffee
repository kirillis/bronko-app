(($, window, document) ->

  $.widget "bronko.voterManager",

    _create: ->

      @total = @element.find('.voter-total')
      @upvote = @element.find('.voter-vote-up')
      @downvote = @element.find('.voter-vote-down')
      @votableId = @element.data('id')

      @_on @upvote,
        'click': (event) ->
          if @upvote.hasClass('is-current')
            @upvote.removeClass('is-current')
            @_resetVote(true)
          else
            @_makeAjax(true)
            @downvote.removeClass('is-current')
            @upvote.addClass('is-current')

      @_on @downvote,
        'click': (event) ->
          if @downvote.hasClass('is-current')
            @downvote.removeClass('is-current')
            @_resetVote(false)
          else
            @_makeAjax(false)
            @upvote.removeClass('is-current')
            @downvote.addClass('is-current')

    _makeAjax: (isUpvote) ->

      if isUpvote
        if @downvote.hasClass('is-current')
          @total.html(parseInt(@total.html()) + 1 )
        @total.html(parseInt(@total.html()) + 1 )
      else
        if @upvote.hasClass('is-current')
          @total.html(parseInt(@total.html()) - 1 )
        @total.html(parseInt(@total.html()) - 1 )

      $.ajax
        url: "/popmeters/" + @votableId + "?is_upvote=" + isUpvote,
        dataType: "script",
        type: "PATCH"

    _resetVote: (isUpvote) ->

      if isUpvote
        @total.html( parseInt(@total.html()) - 1 )
      else
        @total.html( parseInt(@total.html()) + 1 )

      # FIXME: this gives a error 500 response from the server
      $.ajax
        url: "/popmeters/" + @votableId,
        type: "DELETE"

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