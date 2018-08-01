# frozen_string_literal: true

class Task < ApplicationRecord
  validates :subject, presence: true
end
