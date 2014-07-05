class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references 'sub'
      t.references 'user'
      t.text 'title'
      t.text 'text'
      t.text 'link'
      t.boolean 'visible', :default => false

      t.timestamps
    end

    add_index('posts', 'sub_id')
  end
end
