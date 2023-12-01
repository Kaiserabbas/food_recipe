class AddConfirmableToUsers < ActiveRecord::Migration[7.1]
    def change
      add_column :users, :confirmed_at, :datetime
      add_index :users, :confirmed_at, unique: true
    end
  end