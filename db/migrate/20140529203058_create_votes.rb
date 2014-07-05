class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :popmeter
      t.boolean :is_upvote
      t.timestamps
    end
  end
end
