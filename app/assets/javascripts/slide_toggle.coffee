$(document).on "turbolinks:load", ->
  $('[data-slide-toggle-for]').each ->
    toggler = $(this)
    target = $(toggler.data('slide-toggle-for'))
    toggler.find('input').click (e)->
      target.slideToggle()
