require 'rails_helper'

RSpec.describe BackgroundsClient, type: :client do
  describe '::get_background' do
    it 'finds a background based on a search query' do
      VCR.use_cassette('denver_backgrounds') do
        background = BackgroundsClient.get_background('denver,co')
        photo = background[:photos][0]
        expect(background).to have_key(:photos)
        expect(background[:photos]).to be_a(Array)
        expect(photo).to have_key(:url)
        expect(photo).to have_key(:photographer)
        expect(photo).to have_key(:src)
        expect(photo[:src]).to have_key(:medium)

        expect(photo[:url]).to be_a(String)
        expect(photo[:photographer]).to be_a(String)
        expect(photo[:src][:medium]).to be_a(String)
      end
    end
  end
end
