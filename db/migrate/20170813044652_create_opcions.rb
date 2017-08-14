class CreateOpcions < ActiveRecord::Migration[5.1]
  def change
    create_table :opcions do |t|
      t.text :informacion
      t.string :nombre
      t.string :direccion
      t.references :partido, foreign_key: true

      t.timestamps
    end
  end
end
