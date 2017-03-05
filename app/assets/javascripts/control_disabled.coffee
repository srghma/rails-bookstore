$(document).on "turbolinks:load", ->
  $('[data-control-disabled-for]').each ->
    toggler = $(this)
    target = $(toggler.data('control-disabled-for'))
    toggler.find('input').click (e)->
      target.prop 'disabled', !e.target.checked
