class CreateTransacaos < ActiveRecord::Migration
  def change
    create_table :transacaos, :id=>false do |t|
      t.integer :codigo ,:limit=>20
      t.column :tipo, "enum('deposito','saque','pagto','transf') NOT NULL"
      t.integer :nro_conta ,:limit=>20
      t.integer :nro_conta_transf ,:limit=>20
      t.float :valor
      t.date :data

      t.timestamps
    end
  end
end
