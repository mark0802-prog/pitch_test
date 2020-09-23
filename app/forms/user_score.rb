class UserScore
  include ActiveModel::Model
  attr_accessor :user_id, :total_correct_count, :total_wrong_count, :total_time

  def find
    TotalScore.find_by(user_id: user_id)
  end

  def save
    TotalScore.create(user_id: user_id, total_correct_count: 0, total_wrong_count: 0, total_time: 0)
  end

  def update
    TotalScore.update(total_correct_count: total_correct_count, total_wrong_count: total_wrong_count, total_time: total_time)
  end
end
