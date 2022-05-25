require 'rails_helper'

RSpec.describe "create a new message", type: :request do
  subject { get "/messages/#{message.id}" }
  fixtures :users, :messages, :inboxes, :outboxes

  let(:message) { Message.second }

  context 'when the sender of the message is also the reader' do
    before { subject }

    it 'will not mark the message as read' do

      expect(message.reload.read).to eq(false)
    end
  end

  context 'when the sender of the message is not the reader' do
      let(:message) { Message.first }
      before { subject }

      it 'will mark the message as read' do

      expect(message.reload.read).to eq(true)
    end
  end
end
