class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references 'sub'
      t.references 'user'
      t.text 'title'
      t.text 'text'
      t.text 'link'
      t.boolean 'visible', :default => false
      t.integer :sub_comments, :default => 0
      t.integer :votes_diff, :default => 0
      t.float :hotness, :default => 0

      t.timestamps
    end

    add_index('posts', 'sub_id')
  end
end
