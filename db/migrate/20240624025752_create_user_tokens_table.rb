class CreateUserTokensTable < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tokens_tables do |t|
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
