class UsersController < ApplicationController
  def index
    @total_correct_count = TotalScore.includes(:user).order(total_correct_count: :DESC)
    @daily_correct_count = DailyScore.includes(:user)
                                     .where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
                                     .order(daily_correct_count: :DESC)
    @total_correct_rate = TotalScore.includes(:user).order(total_correct_rate: :DESC)
    @daily_correct_rate = DailyScore.includes(:user)
                                    .where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
                                    .order(daily_correct_rate: :DESC)
    @total_average_time = TotalScore.includes(:user).where.not(total_average_time: 0).order(:total_average_time)
    @daily_average_time = DailyScore.includes(:user).where.not(daily_average_time: 0)
                                    .where(created_at: Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
                                    .order(:daily_average_time)
    return unless user_signed_in?

    @user_rank_tcc = user_rank(@total_correct_count)
    @user_rank_dcc = user_rank(@daily_correct_count)
    @user_rank_tcr = user_rank(@total_correct_rate)
    @user_rank_dcr = user_rank(@daily_correct_rate)
    @user_rank_tat = user_rank(@total_average_time)
    @user_rank_dat = user_rank(@daily_average_time)
  end

  private

  def user_rank(type)
    type.each_with_index do |user_id, i|
      return i + 1 if current_user.id == user_id[:user_id]
    end
    '-'
  end
end
