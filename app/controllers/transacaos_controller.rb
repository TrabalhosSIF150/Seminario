class TransacaosController < ApplicationController
  before_filter :authenticate_correntistum!, :except => [:destroy,:update]
  before_filter :authenticate_funcionario!, :except => [:show, :index]
  # GET /transacaos
  # GET /transacaos.json
  def index
    #@transacaos = Transacao.all
    @numero_conta = Contum.find_by_primeiro_corr(current_correntistum.cpf)
    @transacaos = Transacao.where(:nro_conta=>@numero_conta.numero)
    #@transacaos = Transacao.where(:nro_conta=>current_correntistum.contum.numero)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transacaos }
    end
  end

  # GET /transacaos/1
  # GET /transacaos/1.json
  def show
    @transacao = Transacao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transacao }
    end
  end

  # GET /transacaos/new
  # GET /transacaos/new.json
  def new
    @transacao = Transacao.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transacao }
    end
  end

  # GET /transacaos/1/edit
  def edit
    @transacao = Transacao.find(params[:id])
  end

  # POST /transacaos
  # POST /transacaos.json
  def create
    @transacao = Transacao.new(params[:transacao])

    respond_to do |format|
      if @transacao.save
        format.html { redirect_to @transacao, notice: 'Transacao was successfully created.' }
        format.json { render json: @transacao, status: :created, location: @transacao }
      else
        format.html { render action: "new" }
        format.json { render json: @transacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transacaos/1
  # PUT /transacaos/1.json
  def update
    @transacao = Transacao.find(params[:id])

    respond_to do |format|
      if @transacao.update_attributes(params[:transacao])
        format.html { redirect_to @transacao, notice: 'Transacao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @transacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transacaos/1
  # DELETE /transacaos/1.json
  def destroy
    @transacao = Transacao.find(params[:id])
    @transacao.destroy

    respond_to do |format|
      format.html { redirect_to transacaos_url }
      format.json { head :no_content }
    end
  end
end
