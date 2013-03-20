module MongoidForm
  class WrapperConfig

    def initialize(&block)
      instance_eval &block
    end

    def method_missing meth, *args, &block
      if instance_variable_defined? "@#{meth}"
        instance_variable_get "@#{meth}"
      else
        instance_variable_set "@#{meth}", args
      end
    end

  end
end