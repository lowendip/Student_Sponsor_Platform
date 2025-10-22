class CreateDomains < ActiveRecord::Migration[8.0]
  def change
    create_table :domains do |t|
      t.string :name
      t.string :category
      t.references :project, index: true, foreign_key: { to_table: :projects }
      t.timestamps
    end
  end
end
