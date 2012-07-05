bootstrap-validate
==================

A form validation library compatible with twitter bootstrap, using jquery and html5. This library uses the HTML5 validation attributes.

##Installation##

Include the following on your page:

- twitter bootstrap
- jquery (tested under v1.7.1)
- bootstrap.validate js, css and imgs

##Useage##
```html
<form data-validate="yes">
  <fieldset class="control-group">
    <label class="control-label">Email</label>
    <div class="controls">
      <input type="email" name="EMAIL" data-minlength="5" maxlength="100" pattern="[a-z\.]+@[a-z\.]+" required="required">
      <span class="help-inline"></span>
    </div>
  </fieldset>
  <fieldset class="form-actions">
    <button type="submit" class="btn btn-primary">Submit</button>
  </fieldset>
</form>
```
Adding *data-validate="yes"* to your form enabled validations automatically. The validator will disable browser native validations with *novalidate="novalidate"* automatically. The validator attempts to run **FIRST** before any other submit callback can happen, making it more compatible with ajax callbacks that require validation.

Validations are compatible with HTML5 specifications - *pattern*, *maxlength* and *required*. Minlength is not supported by HTML5, but I have included *data-minlength* for completeness.

Validations on a given field will not run unless the field is either populated or *required="required"* is set (or both). This allows you to place validation rules on a field, and still allow blank submissions.

Error/Success messages are automatically populated in the '.help-inline' element that is sibling to the input and both 'success' and 'error' classes are applied to the '.control-group' element.

```javascript
$('form[data-novalidate=yes]').bootstrapValidate();
```
You can also turn on the validation for a given form by calling the jQuery plugin *$.bootstrapValidate()*. This is particularly useful if you are adding forms to the DOM after the page has been rendered.

##TODO##

- support for radio / checkbox elements
