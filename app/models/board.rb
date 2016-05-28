class Board < ActiveRecord::Base

  has_and_belongs_to_many :members, class_name: "User"
  has_many :lists, dependent: :destroy

  validates :title, length: {in: 4..30}, allow_blank: true

  before_save :default_title


  private

  def default_title
    self.title = "Untitled" if self.title.empty? 
  end

end
