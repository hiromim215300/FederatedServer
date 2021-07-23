class AddAddressToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :address, :string
    add_column :microposts, :string, :string
  end
end
