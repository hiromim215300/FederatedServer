class Server < ApplicationRecord
validates :id, presence: true
validates :name, presence: true


require "google/cloud/firestore"
firestore = Google::Cloud::Firestore.new(
  project_id: "sampleapp-735a6",
  credentials: "config/firebase_auth.json"
)

servers_ref = firestore.col("servers").get
servers_ref.map do |server|
  if address = Server.find_by(name: server.data[:name])
    puts "ある"
  else
    puts "ない"
    Server.create(id:server.data[:id], name:server.data[:name])
  end
end
end
