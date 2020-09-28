users = []
100.times do |i|
  password = Faker::Internet.password(min_length: 6)
  users << User.new(nickname: "test#{i}", password: password, password_confirmation: password)
end
User.import users, on_duplicate_key_ignore: true

total_scores = []
daily_scores = []
User.where("nickname like 'test%'").each do |user|
  total_correct_count = rand(1...100)
  total_wrong_count = rand(10...100)
  total_correct_rate = (total_correct_count.to_f / (total_correct_count + total_wrong_count) * 100).round
  total_time = rand(200..500)
  total_average_time = (total_time.to_f / total_correct_count).round(2)
  total_scores << TotalScore.new(user_id: user.id,
                                 total_correct_count: total_correct_count,
                                 total_wrong_count: total_wrong_count,
                                 total_correct_rate: total_correct_rate,
                                 total_time: total_time,
                                 total_average_time: total_average_time)

  daily_correct_count = rand(1...20)
  daily_wrong_count = rand(2...20)
  daily_correct_rate = (daily_correct_count.to_f / (daily_correct_count + daily_wrong_count) * 100).round
  daily_time = rand(40..100)
  daily_average_time = (daily_time.to_f / daily_correct_count).round(2)
  daily_scores << DailyScore.new(user_id: user.id,
                                 daily_correct_count: daily_correct_count,
                                 daily_wrong_count: daily_wrong_count,
                                 daily_correct_rate: daily_correct_rate,
                                 daily_time: daily_time,
                                 daily_average_time: daily_average_time)
end
TotalScore.import total_scores, on_duplicate_key_ignore: true
DailyScore.import daily_scores
