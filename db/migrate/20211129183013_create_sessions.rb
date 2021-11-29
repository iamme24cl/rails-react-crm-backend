class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.integer :bearer_id, null: false
      t.string :bearer_type, null: false
      t.string :token_digest, null: false 

      t.timestamps
    end

    add_index :sessions, [:bearer_id, :bearer_type]
    add_index :sessions, :token_digest, unique: true 
  end
end
