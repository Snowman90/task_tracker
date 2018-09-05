# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/registration
class RegistrationPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/registration/activate
  def activate
    RegistrationMailer.activate(User.new(email: 'aa@foo.pl'))
  end
end
