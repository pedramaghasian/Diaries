class Comment < ApplicationRecord  
    validates :description,presence: true 
    validates :user_id , presence: true 
    validates :diary_id,presence: true 
    belongs_to :user 
    belongs_to :diary 
    default_scope -> {order(updated_at: :desc)}
end