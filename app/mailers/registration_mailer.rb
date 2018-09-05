# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.activate.subject
  #
  def activate(user)
    mail to: user.email
  end
end
