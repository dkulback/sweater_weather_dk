require 'rails_helper'

RSpec.describe BooksClient do
  describe '::search_book' do
    it 'returns a list of 10 books with headers of name, publish_date, etc' do
      VCR.use_cassette('harry_potter') do
        book_search = BooksClient.search_books('denver,co', 5)
        book = book_search[:docs].first
        expect(book_search).to have_key(:docs)
        expect(book).to have_key(:title)
        expect(book).to have_key(:publisher)
        expect(book).to have_key(:isbn)

        expect(book[:title]).to be_a(String)
        expect(book[:publisher]).to be_a(Array)
        expect(book[:isbn]).to be_a(Array)

        expect(book[:title][0]).to be_a(String)
        expect(book[:publisher][0]).to be_a(String)
      end
    end
  end
end
