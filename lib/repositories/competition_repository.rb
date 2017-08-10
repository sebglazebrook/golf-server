require "models/competition"
require "yaml"

module Repositories
  class CompetitionRepository

    COMPETITION_DATA_FILE = PROJECT_ROOT.join("data", "competitions.yaml")

    def self.find!(name)
      data = data_store.fetch(name)
      Models::Competition.new(data)
    end

    def self.data_store
      @data_store ||= YAML.load_file(COMPETITION_DATA_FILE)
    end

  end
end
