class Task < ApplicationRecord
  
  validates :status, presence: true, length: {maximum: 10}
  validates :user_id, presence: true
  
  belongs_to :user
end
