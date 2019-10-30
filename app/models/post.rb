# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  belongs_to :language

  has_many_attached :images

  has_many :favorites, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  validates :language_id, presence: true
  validates :user_id, presence: true

  def  favorited_check?(user)
		favorites.where(user_id: user).exists?
	end
end
