class ServersController < ApplicationController
  def index
   firestore = Google::Cloud::Firestore.new(
     project_id: "sampleapp-735a6",
     credentials: "config/firebase_auth.json"
   )

   server_ref = firestore.col("microposts")
   @server = server_ref.get do |microposts|
     microposts.document_id
   end
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
