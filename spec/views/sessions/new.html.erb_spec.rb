# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'sessions/new.html.erb', type: :view do
  it 'renders form' do
    render

    expect(rendered).to match(/<form/)
  end
end
