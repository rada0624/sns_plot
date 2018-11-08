class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  self.primary_key = 'id'
  has_many :studies_histories, :class_name => :Studies_histories, foreign_key: [:id, :users_id]

  # validates :user_name, presence: true, uniqueness: false
end
