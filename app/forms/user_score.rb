class UserScore
  include ActiveModel::Model
  attr_accessor :user_id, :total_correct_count, :total_wrong_count, :total_correct_rate, :total_time, :total_average_time,
                :daily_correct_count, :daily_wrong_count, :daily_correct_rate, :daily_time, :daily_average_time

  def first_or_create
    total_score = TotalScore.where(user_id: user_id)
                            .first_or_create(user_id: user_id, total_correct_count: 0, total_wrong_count: 0,
                                             total_correct_rate: 0, total_time: 0, total_average_time: 0)
    daily_score = DailyScore.where(user_id: user_id, created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
                            .first_or_create(user_id: user_id, daily_correct_count: 0, daily_wrong_count: 0,
                                             daily_correct_rate: 0, daily_time: 0, daily_average_time: 0)
    UserScore.new(user_id: user_id,
                  total_correct_count: total_score.total_correct_count,
                  total_wrong_count: total_score.total_wrong_count,
                  total_correct_rate: total_score.total_correct_rate,
                  total_time: total_score.total_time,
                  total_average_time: total_score.total_average_time,
                  daily_correct_count: daily_score.daily_correct_count,
                  daily_wrong_count: daily_score.daily_wrong_count,
                  daily_correct_rate: daily_score.daily_correct_rate,
                  daily_time: daily_score.daily_time,
                  daily_average_time: daily_score.daily_average_time)
  end

  def update
    total_score = TotalScore.where(user_id: user_id).first
    daily_score = DailyScore.where(user_id: user_id, created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
                            .first
    return false if total_score.nil? || daily_score.nil?

    total_score.update(total_correct_count: total_correct_count, total_wrong_count: total_wrong_count,
                       total_correct_rate: total_correct_rate, total_time: total_time, total_average_time: total_average_time)
    daily_score.update(daily_correct_count: daily_correct_count, daily_wrong_count: daily_wrong_count,
                       daily_correct_rate: daily_correct_rate, daily_time: daily_time, daily_average_time: daily_average_time)
    true
  end
end
