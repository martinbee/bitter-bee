15.times do
  user = User.create username: Faker::Internet.user_name,
                      email: Faker::Internet.email,
                      password: "password",
                      password_confirmation: "password"
end

50.times do
  user = User.all.sample
  created_at = [*1..23].sample.days.ago
  votes = [*1..30].sample
  Post.create user: user,
                  content: Faker::Hacker.say_something_smart,
                  votes: votes,
                  created_at: created_at,
                  updated_at: created_at
end
