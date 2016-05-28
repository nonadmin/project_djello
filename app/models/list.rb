class List < ActiveRecord::Base

  belongs_to :board
  has_many :cards, dependent: :destroy

  validates :title, 
    length: {in: 4..16}, 
    allow_blank: true
  
  validates :description, 
    length: {in: 10..512}, 
    allow_blank: true
    
end
