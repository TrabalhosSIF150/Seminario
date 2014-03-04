class Correntistum < ActiveRecord::Base
  set_primary_key :cpf
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :cpf, :email, :endereco, :nome, :senha

  has_one :contum

end
