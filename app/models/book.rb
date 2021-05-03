class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(book)
    favorites.where(book_id: book.id).exists?
  end

    #検索
  def self.looks(search, word)
    case search
      when "perfect_match"
        @book = Book.where("title LIKE?", "#{word}")
      when "forward_match"
        @book = Book.where("title LIKE?", "#{word}%")
      when
        @book = Book.where("title LIKE?", "%#{word}")
      when "partial_match"
        @book = Book.where("title LIKE?", "%#{word}%")
      else
        @book = Book.all
    end
  end

end
