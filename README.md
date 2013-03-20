# MongoidForm ``*alpha`` [![Gem Version](https://badge.fury.io/rb/mongoid_form.png)](http://badge.fury.io/rb/mongoid_form)

It makes your life easy when you develop forms and your app use [mongoid](https://github.com/mongoid/mongoid).

## Cool features

### Works with localized fields!

``` ruby  
  # app/models/category.rb
  field :name, localize: true

  # views/category/_form.rb
  = form_for @category, wrapper: :default, html: { class: 'form-horizontal' } do |f|
    = f.localized :name 
    # generates input fields for each locales in your config.i18n.available_locales
    ...
```

### Can show flag block with each localized fields

``` ruby
  # config/initializers/mongoid_form_config.rb
  ...
  # this option add after label text "<div class=\"flag flags-en\" />" to each locale fo localized fields 
  # you should styling .flag > .flags-en (.flags-ru etc.) in your css.
  flag_for_localized  true
  ...
```

### Shows asterisk for required fields!

``` ruby
  # config/initializers/mongoid_form_config.rb
  ...
  # this option add before label text "<abbr title=\"required field\">*</abbr>" to required fields 
  add_if_required :abbr, '*', title: I18n::t('required')
  ...
```

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid_form'

And then execute:

    $ bundle

Run installer for generate sample config:

    $ rails generate mongoid_form:install

## Usage

``` haml
  = form_for @category, wrapper: :backend, html: { class: 'form-horizontal' } do |f|
    = f.error_notification
      
    = f.localized :name
    = f.input :alias                # text_field by default
    = f.input :visible, :checkbox   # pass type of field  
```

## Config

All options for this time:

``` ruby
MongoidForm.setup do |config|
  
  config.wrapper :default do
    alert_error_wrapper :div, class: 'alert alert-error'
    main_error_i18n_key 'errors.form.error_notification'
    group_wrapper       :div, class: 'control-group'
    group_error_class   'error'
    label_options       class: 'control-label'
    add_if_required     :abbr, '*', title: I18n::t('required')
    error_block         :span, class: 'help-inline'
    input_wrapper       :div, class: 'controls'
    flag_for_localized  true
  end

end
```

### Types of fields supported:
  
  * ```:text```
  * ```:password```
  * ```:select```
  * ```:number```
  * ```:text_area```
  * ```:check_box```
  * ```:hidden```
  * ```:file```

If type is ```:hidden``` it will not be wrapped!


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
