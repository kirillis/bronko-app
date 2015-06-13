$(document).on 'page:change', ->

  mainNavigationButton = $('.MobileMenu-burgerButton')
  mainNavigationElement = $('.MobileMenu')

  unless mainNavigationElement.hasClass('is-closed') 
    mainNavigationElement.addClass('is-closed')

  $('.MobileMenu-burgerButton').click ->
    mainNavigationElement.toggleClass('is-closed')