require 'rails_helper'

RSpec.describe "create a new message", type: :request do
  subject { post "/messages", params: create_params }
  fixtures :users, :inboxes, :outboxes

  let(:receiver) { User.second }
  let(:sender_outbox) { Outbox.first }
  let(:receiver_inbox) { Inbox.second }

  let(:create_params) do
    {
      message: { body: "TEXT",
        outbox_id: sender_outbox.id,
        inbox_id: receiver_inbox.id
      }
    }
  end

  context "changes after creation" do
    before { subject }

    it 'the status of the new message is unread' do
      expect(Message.last.read).to eq(false)
    end

    it 'has been sent by the correct user' do
      expect(Message.last.outbox).to eq(sender_outbox)
      expect(Message.last.outbox.user).to eq(sender_outbox.user)
    end

    it 'has been delivered to the correct user' do
      expect(Message.last.inbox).to eq(receiver_inbox)
      expect(Message.last.inbox.user).to eq(receiver_inbox.user)
    end
  end

  context "changes upon creation" do
    it "should increment the count of unread messages by 1" do
    expect{ subject }.to change{ Message.unread.count }.by(1)
  end
  end

end
