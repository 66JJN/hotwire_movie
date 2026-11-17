module CategoriesHelper
  # Deleting a category also deletes its movies (dependent: :destroy), so say so.
  def category_delete_confirmation(category)
    "Delete \"#{category.name}\"? Any movies in it will also be deleted."
  end
end
