module MongoidForm
  module Helpers
    module FormHelper
      
      def localized(name, *args)
        type, options = get_options(args)
        localized_fields(name) { |lf| @template.concat wrap_localized_fields(lf, type, options) }
      end

      def input(name, *args)
        type, options = get_options(args)
        factory type, name, options
      end

      private

        def get_options(args)
          type = args[0]
          options = args.extract_options!
          type ||= :text
          return type, options
        end

    end
  end
end