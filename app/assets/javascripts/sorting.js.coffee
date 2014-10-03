# $(document).on 'page:change', ->
#   $('.sortingForm').find('.sortingForm-methodSelect').addClass('hide');
#   $('.sortingForm').find('.sorting-submit').addClass('hide');

(($, window, document) ->

  $.widget "bronko.sortingManager",

    _create: ->

      @methodSelect = @element.find('.sortingForm-methodSelect')
      @timeSelect = @element.find('.sortingForm-timeSelect')
      @submit = @element.find('.sortingForm-submit')
      @sortingForm = @element.find('.sortingForm')
      @sortingMethod = @element.find('.sortingMethod')

      # get all sorting mehtods from hidden form select and
      # insert new list markup
      @methodSelect.find('option').each (i, element) =>
        isSelected = $(element).attr('selected') == 'selected' ? true : false
        value = $(element).attr('value')
        html = $(element).html()
        if isSelected
          @sortingMethod.append "<li class='sortingMethod-item is-active' data-value='#{value}'>#{html}</li>"
        else
          @sortingMethod.append "<li class='sortingMethod-item' data-value='#{value}'>#{html}</li>"

      # search for links after inserting them into page and
      # bind click events to submit original form
      @sortingMethodLinks = @element.find('.sortingMethod-item')
      @_on @sortingMethodLinks,
        'click': (event) =>
          @resetMethodSelect()
          value = $(event.target).data('value')
          @sortingForm.find("option[value=#{value}]").attr('selected', 'selected')
          @sortingForm.submit()

      @_on @timeSelect,
       'change': (event) =>
          @sortingForm.submit()

    resetMethodSelect: ->
      @methodSelect.find('option').each (i, element) ->
        $(element).attr('selected', false)

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
