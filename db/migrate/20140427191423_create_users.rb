class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string 'username', :limit => 25
      t.string 'password_digest'
      t.string 'email', :limit => 40
      t.string 'remember_token'

      t.timestamps

    end

    add_index('users', 'remember_token')
  end
end
