###!
* jQuery UI Widget-factory plugin boilerplate (for 1.8/9+)
* Author: @addyosmani
* Further changes: @peolanha
* Ported to CoffeeScript: @yckart
* Licensed under the MIT license
###
(($, window, document) ->

  # define your widget under a namespace of your choice
  #  with additional parameters e.g.
  # $.widget( "namespace.widgetname", (optional) - an
  # existing widget prototype to inherit from, an object
  # literal to become the widget's prototype );

  $.widget "bronko.voterManager",

    #Options to be used as defaults
    options:
      someValue: null


    #Setup widget (eg. element creation, apply theming
    # , bind events etc.)
    _create: ->
      # _create will automatically run the first time
      # this widget is called. Put the initial widget
      # setup code here, then you can access the element
      # on which the widget was called via this.element.
      # The options defined above can be accessed
      # via this.options this.element.addStuff();
      console.log "voterManager created."

      @total = @element.find('.voter__total')
      @up = @element.find('.voter__vote--up')
      @down = @element.find('.voter__vote--down')

      @_on @up,
        "click": (event) ->
          event.preventDefault()
          console.log "up button clicked."

        "ajax:success": (e, data, status, xhr) ->
          console.log "ajax upvote success."

      @_on @down,
        "click": (event) ->
          event.preventDefault()
          console.log "down button clicked."

        "ajax:success": (e, data, status, xhr) ->
          console.log "ajax downvote success."

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

    methodB: (event) ->
      #_trigger dispatches callbacks the plugin user
      # can subscribe to
      # signature: _trigger( "callbackName" , [eventObject],
      # [uiObject] )
      # eg. this._trigger( "hover", e /*where e.type ==
      # "mouseenter"*/, { hovered: $(e.target)});
      console.log "methodB called"

    methodA: (event) ->
      @_trigger "dataChanged", event,
        key: "someValue"
      return


    # Respond to any changes the user makes to the
    # option method
    _setOption: (key, value) ->
      switch key
        when "someValue"
          #this.options.someValue = doSomethingWith( value );
        else
          #this.options[ key ] = value;
          break


      # For UI 1.8, _setOption must be manually invoked
      # from the base widget
      $.Widget::_setOption.apply @, arguments_
      # For UI 1.9 the _super method can be used instead
      # this._super( "_setOption", key, value );
      return
  return
) jQuery, window, document