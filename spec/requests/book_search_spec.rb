require 'rails_helper'

RSpec.describe 'book search api', type: :request do
  let(:headers) { { "Content-Type": 'application/json', "Accept": 'application/json' } }
  let(:valid_params) { { location: 'denver,co', quantity: 5 } }
  let(:invalid_params) { { location: '', quantity: -2 } }
  describe 'GET /api/v1/book-search' do
    context 'when params are valid' do
      it 'returns a json response and status 200' do
        VCR.use_cassette('denver_books_forecast') do
          get api_v1_book_search_path, headers: headers, params: valid_params
          json = JSON.parse(response.body, symbolize_names: true)
          books = json[:data][:attributes][:books]
          expect(json).to have_key(:data)
          expect(json[:data]).to have_key(:type)
          expect(json[:data]).to have_key(:attributes)
          expect(json[:data]).to have_key(:id)

          expect(json[:data][:attributes]).to be_a(Hash)

          expect(json[:data][:attributes]).to have_key(:destination)
          expect(json[:data][:attributes]).to have_key(:forecast)
          expect(json[:data][:attributes]).to have_key(:total_books_found)
          expect(json[:data][:attributes]).to have_key(:books)

          expect(json[:data][:attributes][:destination]).to be_a(String)
          expect(json[:data][:attributes][:forecast]).to be_a(Hash)
          expect(json[:data][:attributes][:total_books_found]).to be_a(Integer)
          expect(json[:data][:attributes][:destination]).to be_a(String)

          expect(books).to be_a(Array)
          expect(books[0]).to be_a(Hash)

          expect(books[0]).to have_key(:isbn)
          expect(books[0]).to have_key(:title)
          expect(books[0]).to have_key(:publisher)
          expect(books.count).to eq(5)

          expect(books[0][:isbn]).to be_a(Array)
          expect(books[0][:title]).to be_a(String)
          expect(books[0][:publisher]).to be_a(Array)
          expect(books[0][:publisher].first).to be_a(String)
          expect(books[0][:isbn].first).to be_a(String)

          expect(json[:data][:attributes][:forecast]).to have_key(:summary)
          expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
          expect(json[:data][:attributes][:forecast][:temperature]).to be_a(Float)
          expect(json[:data][:attributes][:forecast][:summary]).to be_a(String)
          expect(response).to have_http_status(200)
        end
      end
    end
    context 'when params are invalid' do
      xit 'returns bad request status and error message' do
        VCR.use_cassette('invalid_background') do
          get api_v1_backgrounds_path, headers: headers, params: invalid_params

          expect(response).to have_http_status(400)
          expect(response.body).to match(/Location parameter is required/)
        end
      end
    end
  end
end
