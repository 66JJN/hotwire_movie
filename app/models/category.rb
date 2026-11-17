class Category < ApplicationRecord
  DEFAULT_COLOR = "#6366f1".freeze

  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :color, presence: true, format: { with: /\A#\h{6}\z/, message: "must be a hex color like #6366f1" }
end
