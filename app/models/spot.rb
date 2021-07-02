class Spot < ApplicationRecord
  has_many :user, dependent: :destroy

  # アクセスしているIPアドレスを返す
  def my_address
   udp = UDPSocket.new
   # クラスBの先頭アドレス,echoポート 実際にはパケットは送信されない。
   udp.connect("128.0.0.0", 7)
   adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
   udp.close
   adrs
  end
end
