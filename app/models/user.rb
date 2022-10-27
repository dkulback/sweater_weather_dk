class User < ApplicationRecord
  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email, case_sensitive: false

  has_secure_password
  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
