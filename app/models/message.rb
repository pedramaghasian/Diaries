class Message < ApplicationRecord
  validates :content , presence: true ,length:{minimum: 1}
  validates :user_id , presence: true

  belongs_to :user 
  
  def self.most_recent
    order(:created_at).last(10)
  end
end