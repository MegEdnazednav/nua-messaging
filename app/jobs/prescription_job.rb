class PrescriptionJob < ActiveJob::Base
  attr_accessor :user

  def perform(user)
    @user = user

    begin
      send_message_to_admin
      send_api_payment_request
      create_payment_record
    rescue

      Rails.logger.error "[PrescriptionJob] Could not finish the request"
    end
  end

  private
  def send_message_to_admin
    @message = Message.create(body: message_body, inbox_id: User.default_admin.inbox.id, outbox_id: user.outbox.id)
  rescue
    Rails.logger.error "[PrescriptionJob] Message not created"
  end

  def send_api_payment_request
    PaymentProviderFactory.provider.debit_card(user)
  rescue
    Rails.logger.error "[PrescriptionJob] Could not connect to API"
  end

  def create_payment_record
    @payment = Payment.create(user_id: user.id)
  rescue
    Rails.logger.error "[PrescriptionJob] Payment not created"
  end

  def message_body
    "User #{user.full_name} wants a new prescription"
  end
end
