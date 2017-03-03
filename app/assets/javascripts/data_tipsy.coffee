$(document).on "turbolinks:load", ->
  $('[data-tipsy]').each ->
    $(this).tipsy fade: true, opacity: 0.6
