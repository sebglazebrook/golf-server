require "models/user"

module Repositories
  class UserRepository

    DATA_FILE = PROJECT_ROOT.join("data", "users.yaml")

    def self.create!(data)
      user = Models::User.new(data)
      self.save!(user)
    end

    def self.save!(user)
      data_store.push(user)
      update_data!(data_store)
      user
    end

    def self.data_store
      @data_store ||= YAML.load_file(DATA_FILE)
    end

    def self.update_data!(data)
      File.open(DATA_FILE, "w") { |f| f.write(data.to_yaml) }
      @data_store = nil
    end

  end
end
