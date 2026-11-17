class Category < ApplicationRecord
  DEFAULT_COLOR = "#6366f1".freeze

  has_many :tasks, dependent: :destroy

  # broadcasts_to ->(category) { "categories" }, target: "categories"
  broadcasts_refreshes_to ->(category) { "categories" }

  # Keep the count on the Categories page in sync. Models have no `turbo_stream` helper
  # (that's for views/controllers); use the broadcast_* methods instead.
  # One after_commit with on: — two after_*_commit with the same method name keep only the last.
  after_commit :broadcast_count, on: %i[create destroy]

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :color, presence: true, format: { with: /\A#\h{6}\z/, message: "must be a hex color like #6366f1" }

  private

  # Turbo::StreamsChannel (not the record's broadcast_*) so the job doesn't carry this record,
  # which no longer exists after destroy. Pass a number: job arguments must be serializable.
  def broadcast_count
    Turbo::StreamsChannel.broadcast_update_later_to "categories-count", target: "categories-count",
      partial: "categories/count", locals: { count: Category.count }
  end
end
