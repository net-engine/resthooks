module ApiToken
  extend ActiveSupport::Concern

  included do
    before_create :generate_api_token
  end

  private

  def generate_api_token
    self.api_token ||= Digest::SHA1.hexdigest(Time.now.to_s + attributes.inspect)
  end
end
