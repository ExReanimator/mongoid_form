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
  end

end