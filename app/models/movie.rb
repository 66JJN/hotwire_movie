class Movie < ApplicationRecord
  belongs_to :category

  # Two enums: where the movie is on the board, and how much we want to watch it.
  enum :status, { want_to_watch: 0, watching: 1, watched: 2 }, default: :want_to_watch, validate: true
  enum :priority, { low: 0, medium: 1, high: 2 }, default: :medium, validate: true

  validates :title, presence: true
  validates :year, numericality: { only_integer: true, in: 1888..2100 }, allow_nil: true

  # Live updates: any create/update/destroy tells pages subscribed to "movies" to refresh (morph).
  broadcasts_refreshes_to ->(movie) { "movies" }

  # High priority first, then most recently changed.
  scope :board_order, -> { order(priority: :desc, updated_at: :desc) }

  # Only filter when a category is chosen; otherwise return every movie.
  scope :in_category, ->(category_id) { category_id.present? ? where(category_id: category_id) : all }

  # Same idea for priority: blank means every priority.
  scope :with_priority, ->(priority) { priority.present? ? where(priority: priority) : all }

  # The status the card's button moves the movie to.
  def next_status
    case status
    when "want_to_watch" then "watching"
    when "watching"      then "watched"
    when "watched"       then "want_to_watch"
    end
  end
end
