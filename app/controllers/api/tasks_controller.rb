class Api::TasksController < Api::UsersController
  def index
    render json: @current_user.tasks, each_serializer: TaskSerializer
  end

  def show
    render json: @current_user.tasks.find(params[:id]), serializer: TaskSerializer
  end

  def create
    task = @current_user.tasks.new(task_params)
    if task.save
      render json: task, serializer: TaskSerializer
    else
      render json: task.errors, status: 422
    end
  end

  def update
    task = @current_user.tasks.find(params[:id])
    if task.update(task_params)
      render json: task, serializer: TaskSerializer
    else
      render json: task.errors, status: 422
    end
  end

  def destroy
    task = @current_user.tasks.find(params[:id])
    task.destroy!
    render json: task, serializer: TaskSerializer
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :done, :deadline)
  end
end
