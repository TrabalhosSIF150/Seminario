class CreateConta < ActiveRecord::Migration
  def change
    create_table :conta, :id=>false do |t|
      t.integer :numero ,:limit=>20
      t.string :primeiro_corr ,:limit=>12
      t.string :segundo_corr ,:limit=>12
      t.string :terceiro_corr ,:limit=>12
      t.float :limite
      t.float :saldo

      t.timestamps
    end
  end
end
