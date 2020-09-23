class UserScore
  include ActiveModel::Model
  attr_accessor :user_id, :total_correct_count, :total_wrong_count, :total_time,
                :daily_correct_count, :daily_wrong_count, :daily_time

  def find
    total_score = TotalScore.find_by(user_id: user_id)
    daily_score = DailyScore.where(user_id: user_id, created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).take
    return UserScore.new(user_id: user_id, total_correct_count: total_score.total_correct_count, total_wrong_count: total_score.total_wrong_count, total_time: total_score.total_time,
      daily_correct_count: daily_score.daily_correct_count, daily_wrong_count: daily_score.daily_wrong_count, daily_time: daily_score.daily_time)
  end

  def find_total
    TotalScore.find_by(user_id: user_id)
  end

  def find_daily
    DailyScore.where(user_id: user_id, created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).take
  end

  def save_total
    TotalScore.create(user_id: user_id, total_correct_count: 0, total_wrong_count: 0, total_time: 0)
  end

  def save_daily
    DailyScore.create(user_id: user_id, daily_correct_count: 0, daily_wrong_count: 0, daily_time: 0)
  end

  def update_total
    TotalScore.update(total_correct_count: total_correct_count, total_wrong_count: total_wrong_count, total_time: total_time)
  end

  def update_daily
    DailyScore.update(daily_correct_count: daily_correct_count, daily_wrong_count: daily_wrong_count, daily_time: daily_time)
  end
end
