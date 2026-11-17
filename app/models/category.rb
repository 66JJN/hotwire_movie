class Category < ApplicationRecord
  DEFAULT_COLOR = "#6366f1".freeze

  has_many :tasks, dependent: :destroy

  # Live updates for the Categories page (subscribed to "categories"), targeting <ul id="categories">.
  after_create_commit  -> { broadcast_append_later_to "categories", target: "categories" }
  after_update_commit  -> { broadcast_replace_later_to "categories" }
  after_destroy_commit -> { broadcast_remove_to "categories" }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :color, presence: true, format: { with: /\A#\h{6}\z/, message: "must be a hex color like #6366f1" }
end
