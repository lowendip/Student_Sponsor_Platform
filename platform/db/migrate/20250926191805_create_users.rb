class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, default: ""
      t.string :organization, default: ""
      t.string :contact, default: ""
      t.string :domains, array: true, default: []
      t.string :role, default: ""
      t.string :username
      t.string :password_digest
      t.timestamps
    end
  end
end
