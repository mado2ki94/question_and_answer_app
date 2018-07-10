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

# 全てのユーザーが３つずつ質問を投稿
5.times do
  users = User.all
  users.each do |user|
    title   = Faker::Lorem.sentence(6)
    content = Faker::Lorem.sentence(50)
    user.questions.create!(title: title ,content: content, resolution: 0)
  end
end

# 全てのユーザーがランダムに３つの質問に回答
3.times do
  users = User.all
  users.each do |user|
    content = Faker::Lorem.sentence(30)
    question_id = rand(1..151)
    user.answers.create(content: content, user_id: user.id, question_id: question_id)
  end
end

# 全てのユーザーがランダムに30の質問と回答にいいね
users = User.all
20.times do
 users.each do |user|
   question_id = rand(1..151)
   question = Question.find_by(id: question_id)
   user.favorite(question)
   answer_id = rand(1..151)
   answer = Answer.find_by(id: answer_id)
   user.like(answer)
 end
end
