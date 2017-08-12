class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.integer :blog_id, null: false, default: 0, comment: 'ブログID'
      t.string :comment,  null: false, default: '', comment: 'コメント'

      t.timestamps
      t.index :blog_id
    end
  end
end
