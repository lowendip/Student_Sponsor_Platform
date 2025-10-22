class ProjectsDomains < ActiveRecord::Migration[8.0]
  def change
    create_join_table :domains, :projects
  end
end
