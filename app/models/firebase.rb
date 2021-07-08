class Firebase
 require 'google/cloud'

 class_attribute :connecting
 self.connecting = Google::Cloud.new(SampleApp).firestore
end
