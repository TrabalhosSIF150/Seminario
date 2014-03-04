class CreateFuncionarios < ActiveRecord::Migration
  def change
    create_table :funcionarios , :id=>false do  |t|
      t.integer :codigo,:limit=>20
      t.string :nome ,:limit=>35
      t.string :email ,:limit=>25
      t.column :funcao ,"enum('gerente','caixa','atendente') NOT NULL"

      t.timestamps
    end
  end
end
