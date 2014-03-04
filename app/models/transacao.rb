class Transacao < ActiveRecord::Base
  set_primary_key :codigo
  attr_accessible :codigo, :data, :nro_conta, :nro_conta_transf, :tipo, :valor
end
