# frozen_string_literal: true

# Handle tasks
class TasksController < ApplicationController
  def index
    @task = Task.new
  end
end
