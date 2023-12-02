require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(name: 'test', email: 'test@test.com', password: 'password')
      user.skip_confirmation! # Bypass confirmation for testing purposes
      user.save
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(name: 'test', password: 'password')
      user.skip_confirmation!
      user.save
      expect(user).to_not be_valid
    end

    it 'is not valid with a password shorter than 6 characters' do
      user = User.new(name: 'test', email: 'test@test.com', password: 'short')
      user.skip_confirmation!
      user.save
      expect(user).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should have many foods' do
      expect(User.reflect_on_association(:foods).macro).to eq(:has_many)
    end

    it 'should have many recipes' do
      expect(User.reflect_on_association(:recipes).macro).to eq(:has_many)
    end
  end
end
