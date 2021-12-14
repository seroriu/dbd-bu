class CreateFaves < ActiveRecord::Migration[5.1]
  def change
    create_table :faves do |t|
      t.integer :faved_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
