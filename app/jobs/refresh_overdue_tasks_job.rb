# Runs every minute (config/recurring.yml). Moves todo/doing tasks whose due date
# has passed to status "overdue", then refreshes the board once so they move live.
class RefreshOverdueTasksJob < ApplicationJob
  queue_as :default

  def perform
    # update_all skips callbacks, so this is one UPDATE and one broadcast
    # instead of one refresh broadcast per task.
    updated = Task.past_due.update_all(status: Task.statuses[:overdue], updated_at: Time.current)
    return if updated.zero?

    Turbo::StreamsChannel.broadcast_refresh_to "tasks"
  end
end
