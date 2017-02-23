$(document).on "turbolinks:load", ->
  isNumericPressed = (event) ->
    event.which != 8 and !isNaN(String.fromCharCode(event.which))

  $('[data-quantity]').each ->
    target = $(this)

    children = target.children()

    $input = target.children('input')
    $plus  = children.last()
    $minus = children.first()

    $input.keypress (event) =>
      event.preventDefault() unless isNumericPressed(event)

    changeInput = (changer) ->
      val = parseInt $input.val()
      $input.val(changer(val))

    $plus.click (event) ->
      event.preventDefault()
      changeInput (quantity) ->
        return 1 unless quantity
        quantity + 1

    $minus.click (event) ->
      event.preventDefault()
      changeInput (quantity) ->
        return 1 unless quantity
        if quantity > 1 then quantity - 1 else quantity

