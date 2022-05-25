require 'rails_helper'

RSpec.describe PrescriptionJob, type: :job do
  before do
    ActiveJob::Base.queue_adapter = :test
  end

  fixtures :users, :inboxes, :outboxes

  let(:prescription_job) { PrescriptionJob.new }
  let(:user) { User.where(is_patient: true).first }

  describe "When the job executes without issues" do
    let(:subject) { prescription_job.perform(user) }

    it 'sends a message to the admin' do
      subject
      expect(Message.last.body).to eq("User #{user.full_name} wants a new prescription")
    end

    it 'creates a payment' do
      expect{ subject }.to change{ Payment.count }.by(1)
    end
  end

  describe "When the job fails for some reason (e.g. no user)" do
    it 'raises an error' do
      expect{prescription_job.perform('no_user')}.to raise_error(an_instance_of(TypeError))
    end
  end
end
