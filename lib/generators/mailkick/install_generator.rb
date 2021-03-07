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
        if encrypted?
          template "model_encrypted.rb", "app/models/mailkick/opt_out.rb"
        end
      end

      def migration_version
        "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
      end

      def email_column
        if encrypted?
          "t.text :email_ciphertext\n      t.string :email_bidx, index: true"
        else
          "t.string :email, index: true"
        end
      end

      def encrypted?
        !options[:unencrypted]
      end
    end
  end
end
