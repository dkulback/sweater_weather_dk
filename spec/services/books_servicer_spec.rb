require 'rails_helper'

RSpec.describe BooksServicer do
  describe '::search_books' do
    it 'returns book poros' do
      VCR.use_cassette('denver_book_search_service') do
        books = BooksServicer.search_books('denver,co', 5).last
        num_found = BooksServicer.search_books('denver,co', 5).first

        books.each do |book|
          expect(book).to be_a(Book)
        end

        expect(num_found).to be_a(Integer)
      end
    end
  end
end
