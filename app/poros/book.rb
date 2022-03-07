class Book
  attr_reader :title, :publisher, :isbn, :num_found

  def initialize(data)
    @title = data[:title]
    @publisher = data[:publisher]
    @isbn = data[:isbn]
    @num_found = data[:num_found]
  end
end
