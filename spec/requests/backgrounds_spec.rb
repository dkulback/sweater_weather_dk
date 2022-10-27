require 'rails_helper'

RSpec.describe 'background api', type: :request do
  let(:headers) { { "Content-Type": 'application/json', "Accept": 'application/json' } }
  let(:valid_params) { { location: 'denver,co' } }
  let(:invalid_params) { { location: '' } }
  describe 'GET /api/v1/backgrouns' do
    context 'when params are valid' do
      it 'returns a json response and status 200' do
        VCR.use_cassette('denver_backgrounds') do
          get api_v1_backgrounds_path, headers: headers, params: valid_params

          backgrounds = JSON.parse(response.body, symbolize_names: true)
          image = backgrounds[:data][:attributes][:image]
          expect(backgrounds).to have_key(:data)
          expect(backgrounds[:data]).to have_key(:type)
          expect(backgrounds[:data]).to have_key(:id)
          expect(backgrounds[:data]).to have_key(:attributes)

          expect(backgrounds[:data]).to be_a(Hash)
          expect(backgrounds[:data][:type]).to be_a(String)
          expect(backgrounds[:data][:id]).to eq(nil)
          expect(backgrounds[:data][:attributes]).to be_a(Hash)

          expect(image).to have_key(:location)
          expect(image).to have_key(:image_url)
          expect(image).to have_key(:image_src)
          expect(image).to have_key(:credit)

          expect(image[:location]).to be_a(String)
          expect(image[:image_url]).to be_a(String)
          expect(image[:image_src]).to be_a(String)
          expect(image[:credit]).to be_a(Hash)

          expect(image[:credit]).to have_key(:author)
          expect(image[:credit]).to have_key(:source)

          expect(image[:credit][:author]).to be_a(String)
          expect(image[:credit][:source]).to be_a(String)

          expect(response).to have_http_status(200)
        end
      end
    end
    context 'when params are invalid' do
      it 'returns bad request status and error message' do
        VCR.use_cassette('invalid_background') do
          get api_v1_backgrounds_path, headers: headers, params: invalid_params

          expect(response).to have_http_status(400)
          expect(response.body).to match(/Location parameter is required/)
        end
      end
    end
  end
end
