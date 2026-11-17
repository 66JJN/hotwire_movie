class Book < ApplicationRecord
  has_one_attached :cover

  # Live updates: every change tells pages subscribed to "books" to refresh (morph).
  broadcasts_to ->(book) { "books" }, target: "book-list"

  validates :title, presence: true
end
