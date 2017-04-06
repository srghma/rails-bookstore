$(document).on "turbolinks:load", ->
  $('.inputmask, [data-inputmask], [data-inputmask-mask], [data-inputmask-alias]').each (ndx, lmnt) ->
    if lmnt.inputmask == undefined
      Inputmask().mask lmnt
