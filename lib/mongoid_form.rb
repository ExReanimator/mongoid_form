require 'mongoid'
require 'action_view'
require "active_support/all"

module MongoidForm
  extend ActiveSupport::Autoload

  autoload :FormBuilder
  autoload :Helpers
  autoload :WrapperConfig

  mattr_accessor :default_wrapper
  @@default_wrapper = :default
  @@wrappers = {}

  def self.setup
    yield self
  end

  def self.wrapper(name, &block)
    if block_given?
      name ||= :default
      @@wrappers[name.to_sym] = MongoidForm::WrapperConfig.new(&block)
    else
      @@wrappers
    end
  end

  def self.wrappers(name)
    name ||= :default
    @@wrappers[name.to_sym] or raise WrapperNotFound, "Couldn't find wrapper with name #{name}"
  end

  class WrapperNotFound < StandardError
  end

end

ActionView::Base.default_form_builder = MongoidForm::FormBuilder
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| "#{html_tag}".html_safe }

ActionView::Helpers::FormBuilder.send :include, MongoidForm::Helpers::FormHelper