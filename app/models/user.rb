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
  
  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end
  
  # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  # remember_digest が nil の場合は remember メソッドを実行する
  def session_token
    remember_digest || remember
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    # remember_digestの暗号化された文字列が 
    # 検証したい値(remember_token)から暗号化する文字列と一致するかを検証
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end