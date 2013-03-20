module MongoidForm
  class FormBuilder < ActionView::Helpers::FormBuilder

    SKIP_WRAP_FOR = [:hidden]
    
    def localized_fields(field, options = {}, &block)
      field_name = "#{field}_translations"
      object = @object.send(field_name).try(:empty?) ? nil : @object.send(field_name)
      name = "#{object_name}[#{field_name}]"

      @template.fields_for(name, object, &block).html_safe
    end

    def localized_text_field(attribute, options = {})
      attribute, options = value_field(attribute, options)
      text_field(attribute, options).html_safe
    end

    def error_notification
      if any_errors?
        alert { I18n::t(*wrapper.main_error_i18n_key, model: @object.class.model_name.human, count: @object.errors.size) }
      end
    end

    def error_message_for(name)
      if any_errors? && has_error?(name)
        alert { get_error(name) }
      end
    end

    def required?(method)
      @object && @object.class.validators_on(method).map(&:class).include?(Mongoid::Validations::PresenceValidator)
    end

    def any_errors?
      @object && @object.respond_to?(:errors) && @object.errors.present?
    end

    def has_error?(name)
      return false unless any_errors?
      @object.errors.messages[name].present?
    end

    private

      def factory(type, name, options = {})
        input = case type
          when :text
            text_field name, options
          when :password
            password_field name, options
          when :select
            options[:collection] ||= []
            select name, options[:collection], options
          when :number
            number_field name, options
          when :text_area
            text_area name, options
          when :check_box
            check_box name, options
          when :hidden
            hidden_field name, options
          when :file
            file_field name, options
          end
        (SKIP_WRAP_FOR.include?(type) || wrapper.nil?) ? input : wrap_field(input, name)
      end

      def wrap_field(input, name)
        label = label(name, *wrapper.label_options) do
          asterisk(name) + @object.class.human_attribute_name(name)
        end

        wrap_group(input, name, label)
      end

      def wrap_localized_fields(builder)
        name = builder.object_name.scan(/\[(.*)_translations\]/).join.to_sym
        result = ''
        I18n.available_locales.each do |locale|
          field = builder.object_name.scan(/(.*)\[(.*)_translations\]/).join('.')
          Rails.logger.info "$$$"*10
          Rails.logger.info wrapper.flag_for_localized.inspect
          flag = wrapper.flag_for_localized.first ? wrap('', [:div, class: "flag flags-#{locale.to_s}"]) : ''
          label = builder.label locale.to_sym, *wrapper.label_options do
            asterisk(name) + I18n::t("mongoid.attributes.#{field}") + flag
          end
          input = builder.localized_text_field locale.to_sym

          result << wrap_group(input, name, label)
        end
        result.html_safe
      end

      def wrapper
        @options[:wrapper] ? MongoidForm.wrappers(@options[:wrapper]) : nil
      end

      def wrap(content, options)
        @template.content_tag *options do
          content
        end
      end

      def asterisk(name)
        required?(name) && wrapper.add_if_required.present? ? @template.content_tag(*wrapper.add_if_required) + ' ' : ''
      end

      def error(name)
        has_error?(name) ? wrap(get_error(name), wrapper.error_block) : ''
      end

      def get_error(name)
        error = get_errors(name)
        error = error.first if error.is_a?(Array)
        error
      end

      def get_errors(name)
        @object.errors.messages[name]
      end

      def input_wrapped(input, name)
        wrapper.input_wrapper.present? ? wrap((input + error(name)), wrapper.input_wrapper) : (input + error(name))
      end

      def wrap_group(input, name, label)
        if wrapper.group_wrapper.present?      
          group_wrapper = wrapper.group_wrapper.dup
          
          if has_error?(name) && wrapper.group_error_class
            extracted = group_wrapper.extract_options!
            options = extracted.merge(class: extracted[:class] + " " + wrapper.group_error_class.first)
            group_wrapper << options
          end

          wrap (label + input_wrapped(input, name)), group_wrapper
        else
          (label + input_wrapped(input, name))
        end
      end

      def alert(&block)
        inner = yield.html_safe
        wrap inner, wrapper.alert_error_wrapper
      end

      def value_field(attribute, options)
        value = @object ? @object[attribute.to_s] : nil
        options = options.merge(value: value)
        return attribute, options
      end

  end
end