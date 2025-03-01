class CreateCircles < ActiveRecord::Migration[8.0]
  def change
    create_table :circles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :following, null: false, foreign_key: { to_table: :users }
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :circles, [:user_id, :following_id], unique: true
  end
end
