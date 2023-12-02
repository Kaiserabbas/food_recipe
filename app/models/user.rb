class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :recipes, foreign_key: :user_id, dependent: :destroy
  has_many :foods, foreign_key: :user_id, dependent: :destroy
  has_many :recipe_foods, dependent: :destroy
  attr_accessor :confirmation_sent_at
  after_create :skip_confirmation!
  validates :name, presence: true

  def skip_confirmation!
    self.confirm
  end
  def admin?
    role == 'admin'
  end
end
