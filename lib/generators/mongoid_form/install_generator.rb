require 'rails/generators'

module MongoidForm
  class InstallGenerator < ::Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    desc "MongoidForm installation generator"

    def install
      say "MongoidForm resources will be installed...", :cyan

      copy_file 'config.rb', File.join('config/initializers', 'mongoid_form_config.rb')

    end

  end
end