$(document).on 'page:change', ->

  mainNavigationButton = $('.mobileMenu-burgerButton')
  mainNavigationElement = $('.siteLinks.siteLinks--mainNavigation')

  unless mainNavigationElement.hasClass('is-closed') 
    mainNavigationElement.addClass('is-closed')

  $('.mobileMenu-burgerButton').click ->
    mainNavigationElement.toggleClass('is-closed')