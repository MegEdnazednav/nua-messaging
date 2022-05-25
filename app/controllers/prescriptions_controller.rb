class PrescriptionsController < ApplicationController
  def create
    PrescriptionJob.new.perform(@current_user)
    redirect_to messages_path
  end
end
