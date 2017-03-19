test_users = (1..4).to_a.map do |n|
  User.new(
    username: Faker::Name.name,
    email:    "test#{n}@example.com",
    password: "testtest"
  )
end

test_users.push(User.new(username: "Test User", email: "test@test.io", password: "testtest"))

titles = ["Interesting URLs", "Must-see websites", "Delicious Recipes", "Popular Sites", "Holiday & Celebration", "Great web apps", "General Idea", "How to be inspired", "Fine Arts", "Be creative"]

urls = ["https://www.google.com/", "https://github.com/", "http://stackoverflow.com/", "https://www.linkedin.com/", "https://www.intuit.com/", "https://www.msn.com/en-us", "https://www.wikipedia.org/", "https://www.youtube.com/", "http://www.iherb.com/", "https://www.amazon.com/gp/goldbox/", "https://www.instagram.com/?hl=en", "https://www.reddit.com/", "http://www.imdb.com/", "https://www.netflix.com/", "https://www.paypal.com/us/home", "https://www.apple.com/", "https://www.office.com/", "http://www.naver.com", "www.bbc.com/news", "https://www.dropbox.com/", "https://twitter.com/?lang=en", "www.baidu.com/", "https://www.zillow.com/", "https://www.chase.com/", "https://www.bankofamerica.com/", "https://www.walmart.com/", "https://weather.com/", "https://www.costco.com/"]

test_users.each do |user|
  user.skip_confirmation!
  user.save
end

users = User.all
titles.each do |title|
  Topic.create!(
    title: title,
    user: users.sample
  )
end

topics = Topic.all
urls.each do |url|
  Bookmark.create!(
    url: url,
    topic: topics.sample,
    user: users.sample
  )
end

bookmarks = Bookmark.all
100.times do
  Like.create!(
    user: users.sample,
    bookmark: bookmarks.sample
  )
end

# Test User should have topics, bookmarks, likes
tester = User.find_by(email: "test@test.io")
tester_titles = ["Reasons to run", "Laugh and Cry", "Open the Window", "Truer than True"]
tester_urls = ["www.joann.com/", "www.michaels.com/", "www.partycity.com/", "https://rubygems.org/", "www.pandora.com/", "http://getbootstrap.com/", "http://fontawesome.io/", "http://bootswatch.com/", "https://www.w3schools.com/", "https://balsamiq.com/", "https://ruby-doc.org/", "http://guides.rubyonrails.org/index.html"]

tester_titles.each do |title|
  tester.topics.create!(title: title)
end


tester_urls.each do |url|
  tester.bookmarks.create!(url: url, topic: Topic.find_by(title: tester_titles.sample))
end

bookmarks = Bookmark.all
10.times do
  tester.likes.create!(bookmark: bookmarks.sample)
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
puts "#{Like.count} likes created"