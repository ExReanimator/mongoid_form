module MongoidForm
  module Helpers
    module FormHelper
      
      def localized(name)
        localized_fields(name) { |lf| @template.concat wrap_localized_fields(lf) }
      end

      def input(name, *args)
        type = args[0]
        options = args.extract_options!
        type ||= :text
        factory type, name, options
      end

    end
  end
end