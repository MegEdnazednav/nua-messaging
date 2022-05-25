module MessageHelper
  def define_receiver(message, user)
    return message.outbox.id unless user.is_patient && message.outbox.user.is_doctor
    message.created_at < 1.week.ago ? User.default_admin.id : User.default_doctor.id
  end
end
