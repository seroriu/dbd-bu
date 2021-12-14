class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :comment_content
      t.references :user, foreign_key: true
      t.string :posted_id
      t.string :integer

      t.timestamps
    end
  end
end
