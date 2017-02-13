$(document).on "turbolinks:load", ->
  $('[data-readmore]').each ->
    target = $(this)

    old_text = target.text()
    showchar = target.data('readmore-showchar') || 100
    return if old_text.length < showchar

    elem = $('<a href="#">')
      .addClass(target.data('readmore-class'))
      .text(target.data('readmore-moretext') || 'Read more')
      .click (e)->
        e.preventDefault()
        target.text(old_text)
        elem.hide()

    target.text(old_text.substr(0, showchar))
    target.append(elem)

