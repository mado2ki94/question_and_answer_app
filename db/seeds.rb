User.create!(name:  "Example User",
             email: "example@example.com",
             password:              "password",
             password_confirmation: "password")

50.times do |n|
 name  = Faker::Name.name
 email = "example-#{n+1}@railstutorial.org"
 password = "password"
 User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

users = User.order(:created_at).take(6)
20.times do
  title   = Faker::Lorem.sentence(3)
  content = Faker::Lorem.sentence(50)
  users.each do |user|
    user.questions.create!(title: title ,content: content, resolution: 0)
  end
end
