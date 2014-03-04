# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131211221940) do

  create_table "conta", :id => false, :force => true do |t|
    t.integer  "numero"
    t.string   "primeiro_corr", :limit => 12
    t.string   "segundo_corr",  :limit => 12
    t.string   "terceiro_corr", :limit => 12
    t.float    "limite"
    t.float    "saldo"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "correntista", :id => false, :force => true do |t|
    t.string   "cpf",                    :limit => 12
    t.string   "nome",                   :limit => 35
    t.string   "endereco",               :limit => 45
    t.string   "email",                  :limit => 25
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "correntista", ["email"], :name => "index_correntista_on_email", :unique => true
  add_index "correntista", ["reset_password_token"], :name => "index_correntista_on_reset_password_token", :unique => true

  create_table "funcionarios", :id => false, :force => true do |t|
    t.integer  "codigo"
    t.string   "nome",                   :limit => 35
    t.string   "email",                  :limit => 25
    t.string   "funcao",                 :limit => 9,                  :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "funcionarios", ["email"], :name => "index_funcionarios_on_email", :unique => true
  add_index "funcionarios", ["reset_password_token"], :name => "index_funcionarios_on_reset_password_token", :unique => true

  create_table "transacaos", :id => false, :force => true do |t|
    t.integer  "codigo"
    t.string   "tipo",             :limit => 8, :null => false
    t.integer  "nro_conta"
    t.integer  "nro_conta_transf"
    t.float    "valor"
    t.date     "data"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

end
