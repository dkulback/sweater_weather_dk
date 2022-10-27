class BooksClient
  def self.get_url(url, location, qty = 1)
    conn = Faraday.new('http://openlibrary.org') do |faraday|
      faraday.params[:q] = location
      faraday.params[:fields] = 'title,publisher,isbn'
      faraday.params[:limit] = qty
    end

    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search_books(location, qty)
    get_url('search.json', location, qty)
  end
end
