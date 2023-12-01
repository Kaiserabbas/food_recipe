class ShoppingListController < ApplicationController
  def index
    @recipe_foods = current_user.recipe_foods.includes(:food, :recipe)
    @shopping_list = @recipe_foods.select { |rf| rf.quantity > rf.food.quantity }
  end
end
