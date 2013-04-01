# MongoidForm ``*alpha`` [![Gem Version](https://badge.fury.io/rb/mongoid_form.png)](http://badge.fury.io/rb/mongoid_form) [![Code Climate](https://codeclimate.com/github/ExReanimator/mongoid_form.png)](https://codeclimate.com/github/ExReanimator/mongoid_form)

It makes your life easy when you develop forms and your app use [mongoid](https://github.com/mongoid/mongoid).

## Cool features

### Works with localized fields!

``` ruby  
  # app/models/category.rb
  field :name, localize: true
  field :content, localize: true

  # views/category/_form.rb
  = form_for @category, wrapper: :default, html: { class: 'form-horizontal' } do |f|
    # text_field type by default
    # generates input fields for each locales in your config.i18n.available_locales
    = f.localized :name
    
    # pass text_area type and some class for example
    # generates text_area fields for each locales in your config.i18n.available_locales
    = f.localized :content, :text_area, class: "tinymce"
    
    ...
```

### Can show flag block with each localized fields

``config/initializers/mongoid_form_config.rb``
``` ruby
  ...
  # this option add after label text "<div class=\"flag flags-en\" />" to each locale fo localized fields 
  # you should styling .flag and .flags-en (.flags-ru etc.) in your css.
  flag_for_localized  true
  ...
```

### Shows asterisk for required fields!

``config/initializers/mongoid_form_config.rb``
``` ruby
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
  = form_for @category, wrapper: :default, html: { class: 'form-horizontal' } do |f|
    = f.error_notification
      
    = f.localized :name
    = f.input :alias                 # text_field by default
    = f.input :visible, :check_box   # passed type of field

    = f.association :location do |lf|
      = f.input :country  # -> category[location_attributes][country]
      = f.input :city     # -> category[location_attributes][city]

    = f.radios_from_collection :gender, collection: { 1 => t('genders.male'), 2 => t('genders.female') }

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


## Config

All options for this time:

``` ruby
MongoidForm.setup do |config|
  
  config.wrapper :default do
    alert_error_wrapper :div, class: 'alert alert-error'       # wrapper for form main error
    main_error_i18n_key 'errors.form.error_notification'       # i18n key for form main error 
    group_wrapper       :div, class: 'control-group'           # it wrap group of label + input
    group_error_class   'error'                                # that class will added to group wrapper if errors for field
    label_options       class: 'control-label'                 # options for label field
    add_if_required     :abbr, '*', title: I18n::t('required') # appears before label text if field is required
    error_block         :span, class: 'help-inline'            # element containing error message, appears after input
    input_wrapper       :div, class: 'controls'                # wrapper element for each input
    flag_for_localized  true                                   # show block with class "flag flags-#{locale}" after label text 
                                                               # of localized fields
    radios_wrapper      :div, class: 'radios'                  # wrapper for radios group
  end

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
