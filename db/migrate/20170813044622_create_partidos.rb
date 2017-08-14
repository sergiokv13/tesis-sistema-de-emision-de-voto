class CreatePartidos < ActiveRecord::Migration[5.1]
  def change
    create_table :partidos do |t|
      t.string :nombre
      t.text :informacion
      t.text :color
      t.text :color_secundario
      t.text :direccion
      t.timestamps
    end
  end
end
