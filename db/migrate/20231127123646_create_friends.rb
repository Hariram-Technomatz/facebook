class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status

      t.timestamps
    end
  end
end
