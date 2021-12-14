class CreateRes < ActiveRecord::Migration[5.1]
  def change
    create_table :res do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
