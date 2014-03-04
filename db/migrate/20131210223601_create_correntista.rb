class CreateCorrentista < ActiveRecord::Migration
  def change
    create_table :correntista , :id=>false do |t|
      t.string :cpf ,:limit=>12
      t.string :nome,:limit=>35
      t.string :endereco ,:limit=>45
      t.string :email ,:limit=>25

      t.timestamps
    end
  end
end
