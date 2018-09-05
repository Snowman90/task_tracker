# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A.+@.+\..+\z/ }

  def activate
    self.active = true
  end

  def activate!
    activate
    save!
  end
end
