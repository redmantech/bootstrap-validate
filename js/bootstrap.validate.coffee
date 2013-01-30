validateTextField = ($field) ->
  value = $field.val()
  error = no
  $helpContainer = $field.siblings('.help-inline')

  if ($field.attr('required') or value isnt '')
    validateName = $field.attr('data-validatename') or $field.attr('name') or 'This field'

    required = $field.attr('required') is 'required'

    minLength = parseInt($field.attr('data-minlength'))
    if isNaN minLength then minLength = 0

    maxLength = parseInt($field.attr('maxlength'))
    if isNaN maxLength then maxLength = off

    pattern = $field.attr('pattern')
    if pattern is '' then pattern = undefined

    error = validateName + ' is required' if required is yes and value is ''

    if error is no and pattern isnt undefined
      error = validateName + ' is invalid' if value.search(new RegExp pattern, 'g') is -1

    if error is no and minLength isnt 0
      error = validateName + ' is too short' unless value.length >= minLength

    if error is no and maxLength isnt off
      error = validateName + ' is too long' unless value.length <= maxLength

    if error isnt no
      $field.closest('.control-group').addClass('error').removeClass('success')
      $helpContainer.html('<i class="icon-remove icon-red"></i> ' + error)
    else
      $field.closest('.control-group').addClass('success').removeClass('error')
      $helpContainer.html('<i class="icon-ok icon-green"></i>')
  else
    $field.closest('.control-group').removeClass('success').removeClass('error')
    $helpContainer.html('')
  
  error

#add a jquery extension.
(($) ->
  $.fn.bootstrapValidate = () ->
    throw new Error('Boostrap Validate Expects A Form') unless @.is('form')

    @.attr('novalidate', 'novalidate').on 'submit', (submitEvent) ->

      errors = [] #array for future extension... possibly error callbacks.

      $('input, textarea', $(@)).not('[type="radio"]').not('[type="checkbox"]').each (i, el) ->
        if error = validateTextField $(el) then errors.push(error)

      unless errors.length is 0
        submitEvent.stopImmediatePropagation()
        return false

    $('input, textarea', @).not('[type="radio"]').not('[type="checkbox"]').on 'change', (changeEvent) ->
      validateTextField $(@);

    $('input, textarea', @).not('[type="radio"]').not('[type="checkbox"]').on 'keyup', (keyupEvent) ->
      $this = $(@)
      timeout = $this.data 'keyup-timeout'
      clearTimeout(timeout) unless timeout is undefined
      timeout = setTimeout(
        -> 
          validateTextField($this)
        750
      )
      $this.data 'keyup-timeout', timeout;


    #make sure validation comes first on submit (before any ajax or other handlers)
    @.each (i, el) ->
      $form = $(el)
      handlers = $form.data('events').submit
      validation = handlers.pop()
      handlers = handlers.splice 0, 0, validation
)(jQuery)

jQuery () ->
  jQuery('form[data-validate="yes"]').bootstrapValidate()
