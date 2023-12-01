class AddUserIdToRecipeFoods < ActiveRecord::Migration[7.1]
    def change
      add_column :recipe_foods, :user_id, :integer
    end
  end