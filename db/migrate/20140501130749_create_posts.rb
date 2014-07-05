class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references 'sub'
      t.references 'user'
      t.string 'title'
      t.string 'text'
      t.string 'link'
      t.boolean 'visible', :default => false

      t.timestamps
    end

    add_index('posts', 'sub_id')
  end
end
