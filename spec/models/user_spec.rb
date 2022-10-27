require 'rails_helper'

RSpec.describe User do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
