class RemoveReferencesFromShowTimings < ActiveRecord::Migration[7.0]
  def change
    remove_reference :show_timings, :booking, null: false, foreign_key: true
  end
end
