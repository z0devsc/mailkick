# must go here to take effect before schema loaded
if ActiveRecord::VERSION::MAJOR < 6 && ActiveRecord::ConnectionAdapters::SQLite3Adapter.respond_to?(:represent_boolean_as_integer=)
  ActiveRecord::ConnectionAdapters::SQLite3Adapter.represent_boolean_as_integer = true
end

ActiveRecord::Schema.define do
  create_table :mailkick_opt_outs do |t|
    if ENV["ENCRYPTED"]
      t.text :email_ciphertext
      t.string :email_bidx, index: true
    else
      t.string :email, index: true
    end
    t.references :user, polymorphic: true
    t.boolean :active, null: false, default: true
    t.string :reason
    t.string :list
    t.timestamps null: false
  end

  create_table :users do |t|
    t.string :email
  end

  create_table :admins do |t|
    t.string :email_address
  end
end
