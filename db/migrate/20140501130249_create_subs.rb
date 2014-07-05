class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.references :user    
      t.string 'name'
      t.string 'description'
      t.boolean 'visible', :default => false

      t.timestamps
    end
  end
end
