require "models/user"
require "exceptions/unknown_user"

module Repositories
  class UserRepository

    # TODO have differnent data dirs for differnt envs
    DATA_FILE = PROJECT_ROOT.join("data", "users.yaml")

    def self.create!(data)
      user = Models::User.new(data)
      self.save!(user)
    end

    def self.save!(user)
      index = nil
      existing_user = data_store.find.with_index do |u, i|
        index = i;
        u.username == user.username rescue false
      end
      if existing_user
        data_store[index] = user
      else
        data_store.push(user)
      end
      update_data!(data_store)
      user
    end

    def self.find!(name)
      data_store.find { |item| item.username == name } || raise(UnknownUser.new)
    end

    def self.reload!
      @data_store = nil
    end

    private

    def self.data_store
      @data_store ||= YAML.load_file(DATA_FILE)
    end

    def self.update_data!(data)
      File.open(DATA_FILE, "w") { |f| f.write(data.to_yaml) }
      reload!
    end

  end
end
