module MongoidForm
  module Helpers
    module FormHelper
      
      def input(name, *args)
        type, options = get_options(args)
        factory type, name, options
      end

      def localized(name, *args)
        type, options = get_options(args)
        localized_fields(name) { |lf| @template.concat wrap_localized_fields(lf, type, options) }
      end

      def association(*args, &block)
        options = args.extract_options!
        options[:wrapper] = self.options[:wrapper] if options[:wrapper].nil?        
        options[:builder] ||= MongoidForm::FormBuilder

        fields_for(*(args << options), &block)
      end

      def radios_from_collection(name, *args)
        options = args.extract_options!
        raise "Collection for radios not passed" unless options[:collection]
        result = ''
        options[:collection].each do |value, text|
          result << radio_button(name, value) + label(name, text)
        end
        radios_block = wrapper.radios_wrapper.present? ? wrap(result.html_safe, wrapper.radios_wrapper) : result.html_safe
        wrap_field(radios_block, name)
      end

      private

        def get_options(args)
          if args.present?
            type = args.first unless args.first.is_a?(Hash)
          end
          options = args.extract_options!
          type ||= :text
          return type, options
        end

    end
  end
end