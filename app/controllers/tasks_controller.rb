class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :set_category, only: [:index]

  # GET /tasks - if @category exists, render only category's tasks. Else, all tasks.
  def index
    if @category 
      render json: @category.tasks
    else 
      render json: Task.all
    end
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Set category of a task in instance variable
    def set_category
      id = params[:category_id]

      if id 
        @category = Category.find(params[:category_id])
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
