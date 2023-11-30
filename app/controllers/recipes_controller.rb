class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, Notice: 'Recipes added successfully'
    else
      flash[:notice] = @recipe.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def destroy
    @recipe.destroy
    authorize! :destroy, @recipe

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe removed successfully.' }
    end
  end

  def show
    @foods = current_user.foods
    @recipe = current_user.recipes.includes(:recipe_foods).find(params[:id])
    @recipes = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.public
      @recipe.update(public: false)
      flash.now[:notice] = 'Status changed to private.'
    else
      @recipe.update(public: true)
      flash.now[:notice] = 'Status changed to public'
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
