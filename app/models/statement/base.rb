module Statement
  class Base
    class_attribute :validators
    self.validators = []

    def self.validates_with(validator, options)
      self.validators << validator.new(options)
    end

    attr_reader :attributes, :errors

    def initialize(attributes = {})
      @attributes = attributes
      @errors = []
    end

    def [](key)
      attributes[key]
    end

    def valid?
      errors.clear
      validate
    end

    def execute
      valid? ? execute! : false
    end

    protected

    def validate
      self.class.validators.each do |validator|
        return false unless validator.validate(self)
      end
      true
    end
  end
end
