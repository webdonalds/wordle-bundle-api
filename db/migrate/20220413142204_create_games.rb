class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :uuid, null: false
      t.string :type
      t.references :user
      t.text :raw_result

      t.index :type
      t.timestamps
    end
  end
end
