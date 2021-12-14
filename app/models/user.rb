class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :comments ,dependent: :destroy  #User.commentsで、ユーザーの所有するコメントを取得できる。
  has_many :posts ,dependent: :destroy
  has_many :re,dependent: :destroy
  has_many :fave ,dependent: :destroy
  
  mount_uploader :image, AvatarUploader
  validates :name, presence: true #追記
  validates :profile, length: { maximum: 200 } #追記

protected
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(name: auth.info.name,
                         email: User.dumy_email(auth),
                         provider: auth.provider,
                         uid: auth.uid,
                         username: auth.info.nickname,
                         password: Devise.friendly_token[0, 20],
                         remote_image_url: auth.info.image #に変更する
                         )
    end
    user
  end
  
  def remember_me
    true
  end
  private

  def self.dumy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com" #POINT
  end
end
