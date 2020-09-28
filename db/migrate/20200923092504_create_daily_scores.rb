class CreateDailyScores < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :daily_correct_count, null: false
      t.integer :daily_wrong_count, null: false
      t.integer :daily_correct_rate, null: false
      t.float :daily_time, null: false
      t.float :daily_average_time, null: false

      t.timestamps
    end
  end
end
