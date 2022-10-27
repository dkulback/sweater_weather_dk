require 'rails_helper'

RSpec.describe 'API Key' do
  describe '::generator' do
    it 'generates a random key' do
      key = ApiKey.generator
      expect(key).to be_a(String)
    end
  end
end
