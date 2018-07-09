User.create!(name:  "Example User",
             email: "example@example.com",
             password:              "password",
             password_confirmation: "password")

# ユーザーを50人作成
50.times do |n|
 name  = Faker::Name.name
 email = "example-#{n + 1}@railstutorial.org"
 password = "password"
 avatar = "#{Rails.root}/app/assets/images/avatar0#{n % 6 + 1}.jpg"
 user = User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              avatar: File.open(avatar))
end

# 全てのユーザーが一つずつ質問を投稿
users = User.all
users.each do |user|
  title   = Faker::Lorem.sentence(6)
  content = Faker::Lorem.sentence(50)
  user.questions.create!(title: title ,content: content, resolution: 0)
end

# 全てのユーザーがランダムに一つの質問に回答
users = User.all
users.each do |user|
  content = Faker::Lorem.sentence(30)
  question_id = rand(1..51)
  user.answers.create(content: content, user_id: user.id, question_id: question_id)
end

# 全てのユーザーがランダムに20の回答にいいね
users = User.all
20.times do
 users.each do |user|
   answer_id = rand(1..51)
   answer = Answer.find_by(id: answer_id)
   user.like(answer)
 end
end
