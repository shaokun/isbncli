module Isbncli
  class IsbnValidator
    attr_reader :isbn

    def self.create(isbn)
      if isbn.nil?
        raise ArgumentError, "ISBN cannot be nil"
      elsif isbn.is_a?(Numeric)
        isbn = isbn.to_s
      elsif !isbn.is_a?(String)
        raise ArgumentError, "ISBN must be a string or number"
      end

      isbn = isbn.delete('-')
      digits = isbn.match(/\d+/)&.[](0)

      if digits.nil?
        raise ArgumentError, "Invalid ISBN format"
      elsif digits.length == 13
        Isbncli::Isbn13Validator.new(digits)
      else
        raise ArgumentError, "Invalid ISBN length #{digits.length}"
      end
    end

    def initialize(isbn)
      @isbn = isbn
    end

    def valid?
      raise NotImplementedError, "Subclasses must implement this method"
    end

    def check_digit
      raise NotImplementedError, "Subclasses must implement this method"
    end

    def calculate_check_digit
      raise NotImplementedError, "Subclasses must implement this method"
    end
  end
end
