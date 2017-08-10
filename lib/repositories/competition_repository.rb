require "models/competition"
require "yaml"

module Repositories
  class CompetitionRepository

    DATA_FILE = PROJECT_ROOT.join("data", "competitions.yaml")

    def self.find!(name)
      data = data_store.fetch(name)
      Models::Competition.new(data.merge(:name => name))
    end

    def self.save!(competition)
      data_store[competition.name] = competition
      update_data!(data_store)
      competition
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
