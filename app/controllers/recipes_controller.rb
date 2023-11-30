class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def show; end

  def new; end

  def create
    @recipe = current_user.recipes.new
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipes_path, notice: 'Recipe was created successfully' }
      else
        format.html do
          flash[:error] = @recipe.errors.full_messages.join(', ')
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy; end

  def update; end

  def edit; end
end
