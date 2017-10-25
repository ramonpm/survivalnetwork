class CreateFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :flags do |t|
      t.references :reporter, references: :survivor, foreign_key: true
      t.references :infected, references: :survivor, foreign_key: true

      t.timestamps
    end
  end
end
