class CreateTotalScores < ActiveRecord::Migration[6.0]
  def change
    create_table :total_scores do |t|
      t.references :user, null: false, foreign_key: true, index: {unique: true}
      t.integer :total_correct_count, null: false
      t.integer :total_wrong_count, null: false
      t.integer :total_correct_rate, null: false
      t.float :total_time, null: false
      t.float :total_average_time, null: false

      t.timestamps
    end
  end
end
