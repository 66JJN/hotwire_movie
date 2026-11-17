[
  { name: "Work",     color: "#6366f1" },
  { name: "Personal", color: "#10b981" },
  { name: "Errands",  color: "#f59e0b" }
].each do |attrs|
  Category.find_or_create_by!(name: attrs[:name]) { |category| category.color = attrs[:color] }
end
