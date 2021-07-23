class Micropost < ApplicationRecord
  belongs_to :user
#  belongs_to :post
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  before_create :create_my_address

  def create_my_address
   udp = UDPSocket.new
   # クラスBの先頭アドレス,echoポート 実際にはパケットは送信されない。
   udp.connect("128.0.0.0", 7)
   adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
   udp.close
   self.address = adrs
  end
  private

    # アップロードされた画像のサイズをバリデーションする
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def create_my_address
   udp = UDPSocket.new
   # クラスBの先頭アドレス,echoポート 実際にはパケットは送信されない。
   udp.connect("128.0.0.0", 7)
   adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
   udp.close
   self.address = adrs
  end
end
