class Post < ApplicationRecord
  has_many :re,dependent: :destroy
  belongs_to :user
end
