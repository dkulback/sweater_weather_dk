class BooksSerializer
  def self.books(forecast, books, location)
    {
      "data": {
        "id": 'null',
        "type": 'books',
        "attributes": {
          "destination": location,
          "forecast": {
            "summary": forecast.current[:conditions],
            "temperature": forecast.current[:temperature]
          },
          "total_books_found": books.first,
          "books": books.last
        }
      }
    }
  end
end
