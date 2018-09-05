# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationMailer, type: :mailer do
  describe 'activate' do
    let(:user) { User.new(email: 'asd@asd.pl', activation_token: SecureRandom.uuid) }
    let(:mail) { RegistrationMailer.activate(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Activate')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
      expect(mail.body.encoded).to match("/activate/#{user.activation_token}")
    end
  end
end
