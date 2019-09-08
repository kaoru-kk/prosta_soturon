class Post < ApplicationRecord
    belongs_to :user
    belongs_to :language

    has_many_attached :images
end
