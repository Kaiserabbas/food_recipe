require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(username: 'test_user', email: 'test@example.com', password: 'password') }

  it 'has many recipe_foods' do
    association = Food.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq(:has_many)
  end

  it 'validates name' do
    food = Food.new(name: nil)
    expect(food).not_to be_valid
    expect(food.errors[:name]).to include("can't be blank")
  end

  it 'validates measurement_unit' do
    food = Food.new(measurement_unit: nil)
    expect(food).not_to be_valid
    expect(food.errors[:measurement_unit]).to include("can't be blank")
  end

  it 'validates price' do
    food = Food.new(price: nil)
    expect(food).not_to be_valid
    expect(food.errors[:price]).to include("can't be blank")
  end

  it 'validates quantity' do
    food = Food.new(quantity: nil)
    expect(food).not_to be_valid
    expect(food.errors[:quantity]).to include("can't be blank")
  end

  it 'price greater_than_or_equal_to 0' do
    food = Food.new(price: -1)
    expect(food).not_to be_valid
    expect(food.errors[:price]).to include('must be greater than or equal to 0')
  end

  it 'quantity greater_than_or_equal_to 0' do
    food = Food.new(quantity: -1)
    expect(food).not_to be_valid
    expect(food.errors[:quantity]).to include('must be greater than or equal to 0')
  end
end
