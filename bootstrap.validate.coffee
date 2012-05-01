$('form[data-validate="yes"]').on 'submit', (e) ->
  alert 'validate'

$('form[data-validate="yes"]').each (i, el) ->
  $form = $(el)
  handlers = $form.data('events').submit
  validation = handlers.pop()
  handlers = handlers.splice 0, 0, validation

