class CorrentistaController < ApplicationController
  before_filter :authenticate_funcionario!

  # GET /correntista
  # GET /correntista.json
  def index
    @correntista = Correntistum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @correntista }
    end
  end

  # GET /correntista/1
  # GET /correntista/1.json
  def show
    @correntistum = Correntistum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @correntistum }
    end
  end

  # GET /correntista/new
  # GET /correntista/new.json
  def new
    @correntistum = Correntistum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @correntistum }
    end
  end

  # GET /correntista/1/edit
  def edit
    @correntistum = Correntistum.find(params[:id])
  end

  # POST /correntista
  # POST /correntista.json
  def create
    @correntistum = Correntistum.new(params[:correntistum])

    respond_to do |format|
      if @correntistum.save
        format.html { redirect_to @correntistum, notice: 'Correntistum was successfully created.' }
        format.json { render json: @correntistum, status: :created, location: @correntistum }
      else
        format.html { render action: "new" }
        format.json { render json: @correntistum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /correntista/1
  # PUT /correntista/1.json
  def update
    @correntistum = Correntistum.find(params[:id])

    respond_to do |format|
      if @correntistum.update_attributes(params[:correntistum])
        format.html { redirect_to @correntistum, notice: 'Correntistum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @correntistum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /correntista/1
  # DELETE /correntista/1.json
  def destroy
    @correntistum = Correntistum.find(params[:id])
    @correntistum.destroy

    respond_to do |format|
      format.html { redirect_to correntista_url }
      format.json { head :no_content }
    end
  end
  def saque
    @conta=Contum.find(params[:conta])
    if @conta.saldo.to_f-params[:saque].to_f>=0
      @conta.update_attribute(:saldo,@conta.saldo.to_f-params[:saque].to_f)
      Transacao.create(:codigo=>DateTime.now.to_i, :data=>Date.today, :nro_conta=>params[:conta], :tipo=>'saque', :valor=>params[:saque])
      respond_to do |format|
        format.html { redirect_to conta_url,alert: "Saque Efetuado com sucesso Saldo diponivel#{@conta.saldo}" }
        format.json { head :no_content }
      end
    elsif (@conta.saldo.to_f+@conta.limite.to_f)-params[:saque].to_f>=0
      aux=@conta.saldo.to_f-params[:saque].to_f
      if aux<0
        @conta.limite=@conta.limite.to_f+aux
        @conta.saldo=0
      end
      @conta.update_attributes(:saldo=>@conta.saldo,:limite=>@conta.limite)
      Transacao.create(:codigo=>DateTime.now.to_i, :data=>Date.today, :nro_conta=>params[:conta], :tipo=>'saque', :valor=>params[:saque])
      respond_to do |format|
        format.html { redirect_to conta_url,alert: "Saque Efetuado com sucesso Saldo diponivel#{@conta.saldo}" }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to conta_url,alert: "Saldo insdiponivel" }
        format.json { head :no_content }
      end
    end
  end
  def transferencia
    @conta=Contum.find(params[:origem])
    @conta2=Contum.find(params[:destino])
    if (@conta.saldo.to_f+@conta.limite.to_f)-params[:valor].to_f>=0
      aux=@conta.saldo.to_f-params[:valor].to_f
      if aux <=0
        @conta.limite=@conta.limite-aux
        @conta.saldo=0
      else
        @conta.saldo=aux
      end
      @conta.update_attributes(:saldo=>@conta.saldo,:limite=>@conta.limite)
      @conta2.update_attribute(:saldo,(@conta2.saldo+params[:valor].to_f))
      Transacao.create(:codigo=>DateTime.now.to_i, :data=>Date.today,:nro_conta=>params[:origem], :nro_conta_transf=>params[:destino],:tipo=>'transf', :valor=>params[:valor])

      @conta
      respond_to do |format|
        format.html { redirect_to conta_url,notice: "Tranferencia efetuada com sucesso!" }
        format.json { head :no_content }
      end
    end

  end

end
