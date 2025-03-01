class CreateSleepHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :clock_in
      t.datetime :clock_out
      t.integer :duration

      t.timestamps
    end

    add_index :sleep_histories, [ :user_id, :clock_in, :duration ]
    add_index :sleep_histories, [ :user_id, :created_at ]
  end
end
