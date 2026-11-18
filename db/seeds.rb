# Sample data for local testing only. Production (Render) starts empty:
# db:prepare runs this file on the first deploy, so stop here outside development.
return unless Rails.env.development?

categories = [
  { name: "Action", color: "#ef4444" },
  { name: "Comedy", color: "#f59e0b" },
  { name: "Drama",  color: "#6366f1" },
  { name: "Sci-Fi", color: "#10b981" }
].to_h do |attrs|
  [ attrs[:name], Category.find_or_create_by!(name: attrs[:name]) { |category| category.color = attrs[:color] } ]
end

# Sample movies, one per board column.
[
  { title: "Interstellar",   year: 2014, category: "Sci-Fi", status: :want_to_watch, priority: :high, note: "Friends say the docking scene is unreal." },
  { title: "Mad Max: Fury Road", year: 2015, category: "Action", status: :watching, priority: :medium, note: "Halfway through." },
  { title: "The Grand Budapest Hotel", year: 2014, category: "Comedy", status: :watched, priority: :low, note: "Rewatch for the colours." }
].each do |attrs|
  Movie.find_or_create_by!(title: attrs[:title]) do |movie|
    movie.assign_attributes(attrs.except(:title, :category).merge(category: categories.fetch(attrs[:category])))
  end
end
