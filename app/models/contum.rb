class Contum < ActiveRecord::Base
  set_primary_key :numero

  #set_foreign_key :primeiro_corr
  attr_accessible :limite, :numero, :primeiro_corr, :segundo_corr, :terceiro_corr , :saldo

  belongs_to :correntistum,:foreign_key => "primeiro_corr"
end
