class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 20 }
  validates :profile, presence: true, uniqueness: true
  validate :check_profile
  #:allow_nilオプションは、対象の値がnilの場合にバリデーションをスキップする
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password
  attr_accessor :remember_token

  def check_profile
    unless self.profile.start_with?("https://libecity.com/user_profile/")
      errors.add(:base, "そのプロフィールURLは使用できません")
    end
  end
end
