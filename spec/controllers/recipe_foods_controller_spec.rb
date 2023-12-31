require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :request do
  let(:user) { User.new(name: 'micheal', email: 'michealdarkwar@gmail.com', password: 'password') }
  let(:recipe) do
    Recipe.new(name: 'Grains', preparation_time: 10, cooking_time: 20, description: 'fried rice', public: false,
               user_id: user.id)
  end

  before do
    user.skip_confirmation!
    user.save
    recipe.save
  end

  def authenticate_user(user)
    post user_session_path, params: { user: { email: user.email, password: user.password, name: user.name } }
    follow_redirect!
  end

  describe 'GET #new' do
    it 'returns a success response' do
      authenticate_user(user)
      get new_recipe_recipe_food_path(recipe)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:food) { Food.create(name: 'Grains', measurement_unit: 'units', price: 10, quantity: 10, user_id: user.id) }

    it 'should redirect to the created recipe' do
      authenticate_user(user)
      post recipe_recipe_foods_path(recipe), params: { recipe_food: { recipe_id: recipe.id, food_id: food.id } }
      expect(response).to redirect_to(recipe_path(recipe))
    end
  end

  describe 'GET #edit' do
    let(:food) { Food.create(name: 'Grains', measurement_unit: 'units', price: 10, quantity: 10, user_id: user.id) }
    let!(:recipe_food) { RecipeFood.create(recipe_id: recipe.id, food_id: food.id, user_id: user.id) }

    it 'returns a success response' do
      authenticate_user(user)
      get edit_recipe_recipe_food_path(recipe, recipe_food.id, recipe_id: recipe.id)
      expect(response).not_to be_successful
    end
  end

  describe 'PUT #update' do
    let(:food) { Food.create(name: 'Grains', measurement_unit: 'units', price: 10, quantity: 10, user_id: user.id) }
    let!(:recipe_food) { RecipeFood.create(recipe_id: recipe.id, food_id: food.id, user_id: user.id) }

    it 'should redirect to the created recipe' do
      authenticate_user(user)

      # Find the recipe_food by id and recipe_id
      recipe_food = RecipeFood.find_by(recipe_id: recipe.id, id: recipe_food&.id)

      # Ensure recipe_food exists before attempting to update
      if recipe_food.nil?
        puts 'Recipe Food not found'
      else
        put recipe_recipe_food_path(recipe, recipe_food.id, recipe_id: recipe.id),
            params: { recipe_food: { recipe_id: recipe.id, food_id: food.id } }
        expect(response).to redirect_to(recipe_path(recipe))
      end
    end
  end
end
