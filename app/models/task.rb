class Task < ApplicationRecord
  belongs_to :category

  # overdue is set by RefreshOverdueTasksJob once due_date has passed (Step 10).
  enum :status, { todo: 0, doing: 1, done: 2, overdue: 3 }, default: :todo, validate: true

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :due_date, presence: true

  # Earliest due date first.
  scope :board_order, -> { order(:due_date, :created_at) }

  # Only filter when a category is chosen; otherwise return every task.
  scope :in_category, ->(category_id) { category_id.present? ? where(category_id: category_id) : all }

  # Not finished yet, and the due date has already passed.
  scope :past_due, -> { where(status: [ :todo, :doing ]).where("due_date < ?", Time.current) }

  # The status the card's button moves the task to.
  def next_status
    case status
    when "todo"    then "doing"
    when "doing"   then "done"
    when "overdue" then "done"
    when "done"    then "todo"
    end
  end
end
