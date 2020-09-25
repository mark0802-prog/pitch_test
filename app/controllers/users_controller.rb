class UsersController < ApplicationController
  def index
    @total_scores = TotalScore.includes(:user).order(total_correct_count: :DESC)
    @daily_scores = DailyScore.includes(:user).where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day).order(daily_correct_count: :DESC)
  end
end
