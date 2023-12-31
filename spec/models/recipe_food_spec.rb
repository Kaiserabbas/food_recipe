require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it 'should belong to recipe' do
      expect(RecipeFood.reflect_on_association(:recipe).macro).to eq(:belongs_to)
    end

    it 'should belong to food' do
      expect(RecipeFood.reflect_on_association(:food).macro).to eq(:belongs_to)
    end
  end
end
