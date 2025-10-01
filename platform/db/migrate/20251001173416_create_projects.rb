class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :short_desc
      t.string :long_desc
      t.string :status, default: "Visible"
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime :expiration
      t.string :domains, array: true, default: []

      t.timestamps
    end
  end
end
