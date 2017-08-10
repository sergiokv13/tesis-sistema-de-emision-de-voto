class CreateEstados < ActiveRecord::Migration[5.1]
  def change
    create_table :estados do |t|
      t.string :estado
      t.integer :id_en_linea
      t.integer :user_id

      t.timestamps
    end
  end
end
