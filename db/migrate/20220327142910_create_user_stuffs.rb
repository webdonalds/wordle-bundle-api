class CreateUserStuffs < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uuid, null: false
      t.string :display_name, null: false
      t.string :email, null: false
      t.timestamps

      t.index :uuid
    end

    create_table :user_authentications do |t|
      t.references :user
      t.string :type, null: false
      t.string :auth_id, null: false
      t.timestamps

      t.index [:type, :auth_id], unique: true
    end

    create_table :api_tokens do |t|
      t.references :user
      t.string :access_key, null: false
      t.string :refresh_key, null: false
      t.datetime :expire_at
      t.timestamps

      t.index :access_key, unique: true
      t.index :refresh_key, unique: true
    end
  end
end
