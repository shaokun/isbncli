require 'rspec'
require 'faker'
require_relative '../lib/isbncli.rb'

describe Isbncli::IsbnValidator do
  describe 'create' do
    context 'when given an invalid ISBN length' do
      it 'raises an ArgumentError' do
        expect { described_class.create('1234567890') }.to raise_error(ArgumentError, 'Invalid ISBN length 10')
      end
    end

    context 'when given a valid ISBN-13' do
      it 'creates an instance of Isbn13Validator' do
        isbn_validator = described_class.create('9780470059029')

        expect(isbn_validator).to be_a(Isbncli::Isbn13Validator)
        expect(isbn_validator.isbn).to eq('9780470059029')
      end
    end

    context 'when given an ISBN with dashes' do
      it 'creates an instance of Isbn13Validator' do
        isbn_validator = described_class.create('978-0-470-05902-9')

        expect(isbn_validator).to be_a(Isbncli::Isbn13Validator)
        expect(isbn_validator.isbn).to eq('9780470059029')
      end
    end

    context 'when given a numeric ISBN' do
      it 'creates an instance of Isbn13Validator' do
        isbn_validator = described_class.create(9780470059029)

        expect(isbn_validator).to be_a(Isbncli::Isbn13Validator)
        expect(isbn_validator.isbn).to eq('9780470059029')
      end
    end

    context 'when given nil' do
      it 'raises an ArgumentError' do
        expect { described_class.create(nil) }.to raise_error(ArgumentError, 'ISBN cannot be nil')
      end
    end

    context 'when given an invalid input' do
      it 'raises an ArgumentError' do
        expect { described_class.create(Object.new) }.to raise_error(ArgumentError, 'ISBN must be a string or number')
      end
    end

    context 'when given an invalid ISBN format' do
      it 'raises an ArgumentError' do
        expect { described_class.create('foo bar') }.to raise_error(ArgumentError, 'Invalid ISBN format')
      end
    end
  end

  describe '#valid?' do
    it 'raises a NotImplementedError when called from the base class' do
      expect { described_class.new('9780470059029').valid? }.to raise_error(NotImplementedError, "Subclasses must implement this method")
    end

    it 'returns true when called from the Isbn13Validator class' do
      100.times do
        isbn = Faker::Code.isbn(base: 13).gsub('-', '')
        expect(described_class.create(isbn).valid?).to eq(true)
      end
    end
  end

  describe '#calculate_check_digit' do
    it 'raises a NotImplementedError when called from the base class' do
      expect { described_class.new('9780470059029').check_digit }.to raise_error(NotImplementedError, "Subclasses must implement this method")
    end

    it 'returns the check digit when called from the Isbn13Validator class' do
      100.times do
        isbn = Faker::Code.isbn(base: 13).gsub('-', '')
        check_digit = isbn[-1]
        expect(described_class.create(isbn).calculate_check_digit).to eq(check_digit)
      end
    end
  end
end
