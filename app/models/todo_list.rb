class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todo_items

  validates :title, presence: true
  validates :title, length: { minimum: 3 }



  scope :name_or_email_search,
   ->(search) {joins(:user).where("users.first_name LIKE ? OR users.email LIKE ?","%#{search}%", "%#{search}%")} 
   
  scope :list_name, -> {where("title like ?","%#{params[:search]}%")}

  def has_completed_items?
    todo_items.complete.size > 0
  end

  def has_incomplete_items?
    todo_items.incomplete.size > 0
  end 
end
