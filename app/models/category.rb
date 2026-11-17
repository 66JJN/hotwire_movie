class Category < ApplicationRecord
  DEFAULT_COLOR = "#6366f1".freeze

  has_many :movies, dependent: :destroy

  # Live updates for the Categories page (subscribed to "categories"), targeting <ul id="categories">.
  # One line = create: append (later), update: replace (later), destroy: remove.
  broadcasts_to ->(category) { "categories" }, target: "categories"

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :color, presence: true, format: { with: /\A#\h{6}\z/, message: "must be a hex color like #6366f1" }
end
