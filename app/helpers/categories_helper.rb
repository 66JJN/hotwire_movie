module CategoriesHelper
  # Deleting a category also deletes its tasks (dependent: :destroy), so say so.
  def category_delete_confirmation(category)
    "Delete \"#{category.name}\"? Any tasks in it will also be deleted."
  end
end
