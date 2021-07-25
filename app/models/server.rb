class Server < ApplicationRecord

require "google/cloud/firestore"
firestore = Google::Cloud::Firestore.new(
  project_id: "sampleapp-735a6",
  credentials: "config/firebase_auth.json"
)

@servers_ref = firestore.col("servers").get


end
