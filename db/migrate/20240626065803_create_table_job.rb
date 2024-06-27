class CreateTableJob < ActiveRecord::Migration[7.1]
  def change
    create_table :table_jobs do |t|
      t.string :title
      t.integer :status
      t.string :created_by_id
      t.timestamp :published_date
      t.string :share_link
      t.integer :salary_from
      t.integer :salary_to

      t.timestamps
    end
  end
end
