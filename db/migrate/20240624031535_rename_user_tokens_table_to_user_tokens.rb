class RenameUserTokensTableToUserTokens < ActiveRecord::Migration[7.1]
  def change
    rename_table :user_tokens_tables , :user_tokens
  end
end
