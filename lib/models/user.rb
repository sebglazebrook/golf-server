module Models
  class User
    
    def initialize(data)
      @data = data
    end

    def ==(other)
      @data == other.instance_variable_get(:"@data")
    end

    def method_missing(name, *args, &block)
      @data[name] || super(name, args, &block)
    end

  end
end
