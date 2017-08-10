require "delegate"
require "ostruct"

module Models
  class Competition < SimpleDelegator

    # TODO competitions need empty users by default
    def initialize(data)
      @data = OpenStruct.new(data)
      super(@data)
    end

    # TODO what is the real status??
    def status
      "hell world"
    end

  end
end
