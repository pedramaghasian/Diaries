class Diary < ApplicationRecord
  validates :name , presence: true , length: {maximum:30}
  validates :description , presence: true, length: {minimum:5,maximum:500}
  validates :user_id , presence: true

  belongs_to :user
  default_scope -> {order(updated_at: :desc)}
  has_many :comments , dependent: :destroy
end