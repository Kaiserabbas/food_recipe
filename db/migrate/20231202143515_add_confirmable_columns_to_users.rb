class AddConfirmableColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
        change_table :users do |t|
      # Add missing columns
      t.string   :confirmation_token unless column_exists?(:users, :confirmation_token)
      t.datetime :confirmed_at unless column_exists?(:users, :confirmed_at)
      t.datetime :confirmation_sent_at unless column_exists?(:users, :confirmation_sent_at)
      t.string   :unconfirmed_email unless column_exists?(:users, :unconfirmed_email)

      # Add missing indexes
      add_index :users, :confirmation_token, unique: true unless index_exists?(:users, :confirmation_token)
    end
  end
end
