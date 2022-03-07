require 'rails_helper'

RSpec.describe Book do
  let(:book) do
    Book.new({ num_found: 12_345, title: 'Denver Book', isbn: %w[12345 123456],
               publisher: ['publisher name', 'penguin'] })
  end
  describe 'initialize' do
    it 'exists' do
      actual = book
      expected = Book
      expect(actual).to be_a(expected)
    end
  end
  describe '#attributes' do
    it 'has a num_found' do
      actual = book.num_found
      expected = 12_345
      expect(actual).to eq(expected)
    end
    it 'has a title' do
      actual = book.title
      expected = 'Denver Book'
      expect(actual).to eq(expected)
    end
    it 'has a publisher' do
      actual = book.publisher
      expected = ['publisher name', 'penguin']
      expect(actual).to eq(expected)
    end
    it 'has a isbn' do
      actual = book.isbn
      expected = %w[12345 123456]
      expect(actual).to eq(expected)
    end
  end
end
