require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    allow_any_instance_of(User).to receive(:save).and_return(true) # Stubbing User creation
  end
  describe 'associations' do
    it 'should have many recipe_foods' do
      expect(Recipe.reflect_on_association(:recipe_foods).macro).to eq(:has_many)
    end

    it 'should belong to a user' do
      expect(Recipe.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    let!(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }

    it 'is valid with valid attributes' do
      recipe = Recipe.new(
        name: 'recipe',
        preparation_time: 10,
        cooking_time: 20,
        description: 'my recipe',
        public: false
      )
      expect(recipe).not_to be_valid
    end

    it 'should validate presence of preparation_time' do
      recipe = Recipe.new(
        name: 'recipe',
        cooking_time: 20,
        description: 'my recipe',
        public: false,
        user_id: user.id
      )
      expect(recipe).not_to be_valid
    end

    it 'should validate presence of cooking_time' do
      recipe = Recipe.new(
        name: 'recipe',
        preparation_time: 10,
        description: 'my recipe',
        public: false,
        user_id: user.id
      )
      expect(recipe).not_to be_valid
    end

    it 'should validate presence of user_id' do
      recipe = Recipe.new(
        name: 'recipe',
        preparation_time: 10,
        cooking_time: 20,
        description: 'my recipe',
        public: false
      )
      expect(recipe).not_to be_valid
    end
  end
end
