class Micropost < ApplicationRecord

require "google/cloud/firestore"
firestore = Google::Cloud::Firestore.new(
  project_id: "sampleapp-735a6",
  credentials: "config/firebase_auth.json"
)

servers_ref = firestore.collection("microposts")
servers_ref.cols do |col|
  puts col.collection_id
end

end
