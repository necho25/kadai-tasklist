class Task < ApplicationRecord
  belongs_to :user #user(1)に対してtask(多)の関係を表している
  
  validates :content, presence: true, length: {maximum:255}
  validates :status, presence: true, length: {maximum:10}

end
