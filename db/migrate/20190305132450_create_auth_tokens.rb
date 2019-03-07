class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens do |t|
      t.integer :user_id, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :auth_tokens, :user_id
    add_index :auth_tokens, :token, unique: true
  end
end
