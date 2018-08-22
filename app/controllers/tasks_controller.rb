# frozen_string_literal: true

# Handle tasks
class TasksController < ApplicationController
  before_action :find_task, only: %i[edit destroy]

  def index
    @task = Task.new
    @tasks = Task.all.order(created_at: :desc)
  end

  def search
    render json: Task.where('subject LIKE ?', "#{params[:query]}%").pluck(:subject)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      @tasks = Task.all
      render action: :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    @task.destroy
    head :ok
  end

  private

  def task_params
    params.require(:task).permit(:subject)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
