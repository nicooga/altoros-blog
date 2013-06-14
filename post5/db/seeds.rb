require 'ffaker'

Post.create!(
  Array.new(10) do
    {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraphs(3).map { |s| "<p>#{s}<\p>\n" }.join
    }
  end
)

puts "Created 10 Posts"