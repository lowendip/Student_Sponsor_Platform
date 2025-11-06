class UsersDomains < ActiveRecord::Migration[8.0]
  def change
    create_join_table :domains, :users
  end
end
