class ContacriarController < ApplicationController
      before_filter :authenticate_correntistum!


      def index

        @conta = Contum.where("primeiro_corr = '#{current_correntistum.cpf}' or  segundo_corr= '#{current_correntistum.cpf}' or terceiro_corr  = '#{current_correntistum.cpf}'")

        respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @conta }
        end


      end


  # GET /conta/1
  # GET /conta/1.json
  def show
    @contum = Contum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contum }
    end
  end

  # GET /conta/new
  # GET /conta/new.json
  def new
    @contum = Contum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contum }
    end
  end

  # GET /conta/1/edit
  def edit
    @contum = Contum.find(params[:id])
  end

  # POST /conta
  # POST /conta.json
  def create
    @contum = Contum.new(params[:contum])

    respond_to do |format|
      if @contum.save
        format.html { redirect_to @contum, notice: 'Contum was successfully created.' }
        format.json { render json: @contum, status: :created, location: @contum }
      else
        format.html { render action: "new" }
        format.json { render json: @contum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /conta/1
  # PUT /conta/1.json
  def update
    @contum = Contum.find(params[:id])

    respond_to do |format|
      if @contum.update_attributes(params[:contum])
        format.html { redirect_to @contum, notice: 'Contum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conta/1
  # DELETE /conta/1.json
  def destroy
    @contum = Contum.find(params[:id])
    @contum.destroy

    respond_to do |format|
      format.html { redirect_to conta_url }
      format.json { head :no_content }
    end
  end

  def saque
    @conta=Contum.find(params[:conta])
    if @conta.saldo.to_f-params[:saque].to_f>=0
      @conta.update_attribute(:saldo,@conta.saldo.to_f-params[:saque].to_f)
      Transacao.create(:codigo=>DateTime.now.to_i, :data=>Date.today, :nro_conta=>params[:conta], :tipo=>'saque', :valor=>params[:saque])
      respond_to do |format|
        format.html { redirect_to contacriar_url,alert: "Saque Efetuado com sucesso Saldo diponivel#{@conta.saldo}" }
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
        format.html { redirect_to contacriar_url,alert: "Saque Efetuado com sucesso Saldo diponivel#{@conta.saldo}" }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to contacriar_url,alert: "Saldo insdiponivel" }
        format.json { head :no_content }
      end
    end
  end

  def deposito
    @conta=Contum.find(params[:conta])
    @conta.update_attributes(:saldo=>params[:saque].to_f+@conta.saldo.to_f)
    Transacao.create(:codigo=>DateTime.now.to_i, :data=>Date.today,:nro_conta=>params[:conta], :tipo=>'deposito', :valor=>params[:saque])
    respond_to do |format|
      format.html { redirect_to contacriar_url,notice: "Deposito efetuado com sucesso novo" }
      format.json { head :no_content }
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
        Transacao.create(:codigo=>DateTime.now.to_i, :data=>Date.today,:nro_conta=>params[:origem], :nro_conta_transf=>params[:destino],:tipo=>'transf', :valor=>params[:saque])

      @conta
        respond_to do |format|
          format.html { redirect_to "/contacriar",notice: "Tranferencia efetuada com sucesso!" }
          format.json { head :no_content }
        end
      end

  end

  def extrato
           @extrato=Transacao.where("nro_conta = ?  and data > ?",params[:conta],params[:data].to_date-30)
  end

  def saldo
        @conta=Contum.find_by_numero(params[:conta])
  end

end
