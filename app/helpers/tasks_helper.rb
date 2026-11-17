module TasksHelper
  BOARD_COLUMNS = %w[todo doing overdue done].freeze
  NEXT_STATUS_ACTIONS = { "doing" => "Start", "done" => "Complete", "todo" => "Reopen" }.freeze

  def status_options
    Task.statuses.keys.map { |status| [ status.humanize, status ] }
  end

  def next_status_action(task)
    NEXT_STATUS_ACTIONS.fetch(task.next_status)
  end
end
