class QuizesController < ApplicationController
  before_action :authenticate_user!, only: :update
  def index
    return unless user_signed_in?

    @scores = UserScore.new(user_id: current_user.id).first_or_create
  end

  def update
    bool = UserScore.new(params_scores).update
    redirect_to quizes_path unless bool
  end

  private

  def params_scores
    params.require(:user_score).permit(:total_correct_count, :total_wrong_count, :total_correct_rate, :total_time, :total_average_time,
                                       :daily_correct_count, :daily_wrong_count, :daily_correct_rate, :daily_time, :daily_average_time).merge(user_id: current_user.id)
  end
end
