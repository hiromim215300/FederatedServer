class ServersController < ApplicationController

  def index
   firestore = Google::Cloud::Firestore.new(
     project_id: "sampleapp-735a6",
     credentials: "config/firebase_auth.json"
   )

   servers_ref = firestore.col("microposts").document("192.168.2.102").collection("collection")    
   @servers = servers_ref.get
  end

  def get_from_firestore
#    @servers = Server.paginate(page: params[:page])
    firestore = Google::Cloud::Firestore.new(
      project_id: "sampleapp-735a6",
      credentials: "config/firebase_auth.json"
    )

    server_ref = firestore.collection("microposts")
    server_ref.get do |col|
      puts col.document_id
    end
  end
end
