class UsersController < ApplicationController
  def index
    @total_correct_count = TotalScore.includes(:user).order(total_correct_count: :DESC)
    @daily_correct_count = DailyScore.includes(:user).where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).order(daily_correct_count: :DESC)
    @total_correct_rate = TotalScore.includes(:user).order(total_correct_rate: :DESC)
    @daily_correct_rate = DailyScore.includes(:user).where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).order(daily_correct_rate: :DESC)
    @total_average_time = TotalScore.includes(:user).order(:total_average_time)
    @daily_average_time = DailyScore.includes(:user).where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).order(:daily_average_time)
  end
end
