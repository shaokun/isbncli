module Isbncli
  class Isbn13Validator < IsbnValidator
    def valid?
      digits = isbn.chars.map(&:to_i)
      check_digit = digits.pop
      sum = digits.each_with_index.reduce(0) do |sum, (digit, index)|
        sum + (index.even? ? digit * 1 : digit * 3)
      end
      (10 - sum % 10) % 10 == check_digit
    end

    def check_digit
      isbn[-1]
    end

    def calculate_check_digit
      digits = isbn.chars.map(&:to_i)
      digits.pop # Remove the check digit
      sum = digits.each_with_index.reduce(0) do |sum, (digit, index)|
        sum + (index.even? ? digit * 1 : digit * 3)
      end
      check_digit = (10 - sum % 10) % 10
      check_digit.to_s
    end
  end
end
