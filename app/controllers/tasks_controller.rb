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

  def update
    if @task.update(task_params)
      respond_to do |format|
        # From a card on the board (status button): update just that card.
        # From the full edit page: a normal redirect.
        format.turbo_stream if turbo_frame_request?
        format.html { redirect_to tasks_path, notice: "Task updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
    respond_to do |format|
      format.turbo_stream # destroy.turbo_stream.erb: remove just this card
      format.html { redirect_to tasks_path, notice: "Task deleted.", status: :see_other }
    end
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
