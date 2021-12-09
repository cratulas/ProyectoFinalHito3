class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  validates :photo, presence: true, blob: {content_type: ["image/jpeg", "image/png"], size_range: 0..5.megabytes}

end
