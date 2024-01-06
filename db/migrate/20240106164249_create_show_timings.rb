class CreateShowTimings < ActiveRecord::Migration[7.0]
  def change
    create_table :show_timings do |t|
      t.datetime :show_time
      t.references :movie, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
