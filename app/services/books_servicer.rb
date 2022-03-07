class BooksServicer
  def self.search_books(location, qty)
    num_found = BooksClient.search_books(location, qty)[:num_found]
    books = BooksClient.search_books(location, qty)[:docs].map do |data|
      Book.new(data)
    end
    [num_found, books]
  end
end
