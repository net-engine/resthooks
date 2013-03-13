class NotificationWorker
  attr_reader :url, :payload

  include Sidekiq::Worker
  include HTTParty

  sidekiq_options queue: :notifications

  def perform(args = {})
    args.symbolize_keys!
    @url = args[:url]
    @payload = args[:payload]

    deliver_notification
  end

  private

  def deliver_notification
    begin
      @response = self.class.post url,
        body: payload,
        headers: { 'Accept' => 'application/json',
                   'Content-type' => 'application/json' }

    rescue Errno::ECONNREFUSED, SocketError, Timeout::Error, Exception => ex
      Rails.logger.info "#{ex.message}\n"
    else
      true
    end
  end
end
