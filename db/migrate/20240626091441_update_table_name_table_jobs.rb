class UpdateTableNameTableJobs < ActiveRecord::Migration[7.1]
  def change
    rename_table :table_jobs , :jobs
  end
end
