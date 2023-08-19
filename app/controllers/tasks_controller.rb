class TasksController < ApplicationController
  before_action :set_task, only: %i[edit show update destroy toggle]

  def index
    @task = Task.new
    @tasks = Task.all
  end

  def not_completed_count
    @not_completed_count = Task.where(completed: false).count

    render json: { count: @not_completed_count }
  end

  def not_completed
    @task = Task.new
    @tasks = Task.where(completed: false)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @tasks }
    end
  end

  def completed
    @task = Task.new
    @tasks = Task.where(completed: true)

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @tasks }
    end
  end

  def edit; end

  def show
    render json: @task
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: 'Task has been successfully updated' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task has been successfully created' }
      else
        @tasks = Task.all
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    redirect_to tasks_url, notice: 'Task has been successfully deleted.'
  end

  def delete_completed
    completed_tasks = Task.where(completed: true)

    if completed_tasks.any?
      completed_tasks.destroy_all
      redirect_to tasks_url, notice: 'Completed tasks have been deleted.'
    else
      redirect_to tasks_url, notice: 'No completed tasks to delete.'
    end
  end

  def toggle
    @task.update(completed: params[:completed])

    render json: { message: 'Success' }
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
