class CreateFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :flags do |t|
      t.references :reporter, foreign_key: {to_table: :survivors}
      t.references :infected, foreign_key: {to_table: :survivors}

      t.timestamps
    end
  end
end
