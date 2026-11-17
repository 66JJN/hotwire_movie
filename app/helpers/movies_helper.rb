module MoviesHelper
  BOARD_COLUMNS = %w[want_to_watch watching watched].freeze
  NEXT_STATUS_ACTIONS = { "watching" => "Start watching", "watched" => "Mark as watched", "want_to_watch" => "Watch again" }.freeze

  def status_options
    Movie.statuses.keys.map { |status| [ status.humanize, status ] }
  end

  def next_status_action(movie)
    NEXT_STATUS_ACTIONS.fetch(movie.next_status)
  end
end
