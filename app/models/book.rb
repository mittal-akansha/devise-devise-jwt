class Book < ApplicationRecord
  scope :search, ->(query) {
    where("name ILIKE ? OR title ILIKE ? OR genre ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  }
  belongs_to :author
end
