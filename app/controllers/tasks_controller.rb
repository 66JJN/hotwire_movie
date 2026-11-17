class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy]
  before_action :set_categories, only: %i[index new edit create update]

  def index
    @tasks = Task.includes(:category).in_category(params[:category_id]).board_order.group_by(&:status)
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Used by both the edit page and the status button on each card.
  # Step 7: answer the card's button with a Turbo Stream instead of a redirect.
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Step 7: answer with a Turbo Stream that removes just this card.
  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: "Task deleted.", status: :see_other
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_categories
    @categories = Category.order(:name)
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :category_id)
  end
end
