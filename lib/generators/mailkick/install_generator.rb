require "rails/generators/active_record"

module Mailkick
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration
      source_root File.join(__dir__, "templates")

      class_option :unencrypted, type: :boolean

      def copy_migration
        migration_template "install.rb", "db/migrate/install_mailkick.rb", migration_version: migration_version
      end

      def generate_model
        unless options[:unencrypted]
          template "model_encrypted.rb", "app/models/mailkick/opt_out.rb"
        end
      end

      def migration_version
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end
    end
  end
end
