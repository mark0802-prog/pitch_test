class QuizesController < ApplicationController
  before_action :authenticate_user!, only: :update
  def index
    return unless user_signed_in?

    @total_score = UserScore.new(user_id: current_user.id).find
    return unless @total_score.nil?

    @total_score = UserScore.new(user_id: current_user.id)
    if @total_score.save
      redirect_to quizes_path
    else
      redirect_to root_path
    end
  end

  def update
    @total_score = UserScore.new(user_id: current_user.id).find
    redirect_to root_path unless @total_score.update(params_total_score)
  end

  private

  def params_total_score
    params.require(:total_score).permit(:total_correct_count, :total_wrong_count, :total_time)
  end
end
