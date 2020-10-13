class Api::TasksController < ApplicationController
  def index
    render json: Task.all, each_serializer: TaskSerializer
  end

  def show
    render json: Task.find(params[:id]), serializer: TaskSerializer
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, serializer: TaskSerializer
    else
      render json: task.errors, status: 422
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      render json: task, serializer: TaskSerializer
    else
      render json: task.errors, status: 422
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    render json: task, serializer: TaskSerializer
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :done, :deadline)
  end
end
