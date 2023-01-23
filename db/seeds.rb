# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  profile: "https://libecity.com/user_profile/test",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
name  = Gimei.unique.name.kanji
profile = "https://libecity.com/user_profile/test#{n+1}"
password = "password"
User.create!(name:  name,
    profile: profile,
    password:              password,
    password_confirmation: password)
end

# 最初の6人だけにエピソードを追加
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Games::Pokemon.name
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.episodes.create!(title: title, content: content) }
end
