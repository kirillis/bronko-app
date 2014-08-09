class CreatePopmeters < ActiveRecord::Migration
  def change
    create_table :popmeters do |t|
        t.integer :upvotes, :default => 0
        t.integer :downvotes, :default => 0
        t.integer :total, :default => 0
        t.float :hotness, :default => 0
        t.float :score, :default => 0
        t.references :votable, :polymorphic => true
        t.timestamps
    end
  end
end
