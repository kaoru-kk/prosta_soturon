# frozen_string_literal: true

class Language < ApplicationRecord
  has_many :posts
end
