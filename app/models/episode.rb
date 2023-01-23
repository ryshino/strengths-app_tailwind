class Episode < ApplicationRecord
  belongs_to :user
  # 最新のものから表示をする
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  # 文字制限は変更予定
  validates :content, presence: true, length: { maximum: 1000 }
end
