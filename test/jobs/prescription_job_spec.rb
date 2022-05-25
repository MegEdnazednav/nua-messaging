require 'rails_helper'

RSpec.describe PrescriptionJob, type: :job do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  fixtures :users, :inboxes, :outboxes

  let(:prescription_job) { PrescriptionJob.new }
  let(:user) { User.where(is_patient: true).first }

  describe "When the job executes without issues" do
    it 'sends a message to the admin' do
      prescription_job.perform(user)
      expect(Message.last.body).to eq("User #{user.full_name} wants a new prescription")
    end

    it 'creates a payment' do
      prescription_job.perform(user)
      expect{ prescription_job.perform(user) }.to change{ Payment.count }.by(1)
    end
  end
end
