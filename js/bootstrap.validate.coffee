$('form[data-validate="yes"]').attr('novalidate', 'novalidate').on 'submit', (submitEvent) ->
  errors = [] #array for future extension... possibly error callbacks.

  $('input, textarea', $(@)).not('[type="radio"]').not('[type="checkbox"]').each (i, el) ->
    $this = $(@)
    value = $this.val()
    error = no
    $helpContainer = $this.siblings('.help-inline')

    if ($this.attr('required') or value isnt '')
      validateName = $this.attr('data-validatename') or $this.attr('name') or 'This field'

      required = $this.attr('required') is 'required'

      minLength = parseInt($this.attr('data-minlength'))
      if isNaN minLength then minLength = 0

      maxLength = parseInt($this.attr('maxlength'))
      if isNaN maxLength then maxLength = off

      pattern = $this.attr('pattern')
      if pattern is '' then pattern = undefined

      errors.push(error = validateName + ' is required') if required is yes and value is ''

      if error is no and pattern isnt undefined
        errors.push(error = validateName + ' is invalid') if value.search(new RegExp pattern, 'g') is -1

      if error is no and minLength isnt 0
        errors.push(error = validateName + ' is too short') unless value.length >= minLength

      if error is no and maxLength isnt off
        errors.push(error = validateName + ' is too long') unless value.length <= maxLength

      if error isnt no
        $this.closest('.control-group').addClass('error').removeClass('success')
        $helpContainer.html('<i class="icon-remove icon-red"></i> ' + error)
      else
        $this.closest('.control-group').addClass('success').removeClass('error')
        $helpContainer.html('<i class="icon-ok icon-green"></i>')

  unless errors.length is 0
    submitEvent.stopImmediatePropagation()
    return false

#make sure validation comes first on submit (before any ajax or other handlers)
$('form[data-validate="yes"]').each (i, el) ->
  $form = $(el)
  handlers = $form.data('events').submit
  validation = handlers.pop()
  handlers = handlers.splice 0, 0, validation

