class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post
      t.references :user
      t.float :score, :default => 0
      t.integer :sub_comments, :default => 0
      t.integer :votes_diff, :default => 0
      t.text :text
      t.string :ancestry

      t.timestamps
    end

  end
end
