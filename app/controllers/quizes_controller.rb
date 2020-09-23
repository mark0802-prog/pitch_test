class QuizesController < ApplicationController
  before_action :authenticate_user!, only: :update
  def index
    return unless user_signed_in?

    @total_score = UserScore.new(user_id: current_user.id).find_total
    @daily_score = UserScore.new(user_id: current_user.id).find_daily
    if @total_score.nil?
      @total_score = UserScore.new(user_id: current_user.id)
      if @total_score.save_total
        redirect_to quizes_path and return
      else
        redirect_to root_path and return
      end
    end
    if @daily_score.nil?
      @daily_score = UserScore.new(user_id: current_user.id)
      if @daily_score.save_daily
        redirect_to quizes_path and return
      else
        redirect_to root_path and return
      end
    end
    @scores =  UserScore.new(user_id: current_user.id).find
  end

  def update
    @total_score = UserScore.new(user_id: current_user.id).find_total
    @daily_score = UserScore.new(user_id: current_user.id).find_daily
    redirect_to quizes_path and return if @daily_score.nil?
    
    redirect_to root_path and return unless @total_score.update(params_total_score)
    redirect_to root_path and return unless @daily_score.update(params_daily_score)
  end

  private

  def params_total_score
    params.require(:user_score).permit(:total_correct_count, :total_wrong_count, :total_time)
  end

  def params_daily_score
    params.require(:user_score).permit(:daily_correct_count, :daily_wrong_count, :daily_time)
  end
end
