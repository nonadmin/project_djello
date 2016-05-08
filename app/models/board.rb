class Board < ActiveRecord::Base

  has_and_belongs_to_many :members, class_name: "User"
  has_many :lists, dependent: :destroy

end
