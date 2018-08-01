# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/index.html.erb', type: :view do
  it 'renders form' do
    assign(:task, Task.new)

    render

    expect(rendered).to match(/<form/)
  end
end
