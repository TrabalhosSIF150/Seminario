require 'test_helper'

class CorrentistaControllerTest < ActionController::TestCase
  setup do
    @correntistum = correntista(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:correntista)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create correntistum" do
    assert_difference('Correntistum.count') do
      post :create, correntistum: { cpf: @correntistum.cpf, email: @correntistum.email, endereco: @correntistum.endereco, nome: @correntistum.nome, senha: @correntistum.senha }
    end

    assert_redirected_to correntistum_path(assigns(:correntistum))
  end

  test "should show correntistum" do
    get :show, id: @correntistum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @correntistum
    assert_response :success
  end

  test "should update correntistum" do
    put :update, id: @correntistum, correntistum: { cpf: @correntistum.cpf, email: @correntistum.email, endereco: @correntistum.endereco, nome: @correntistum.nome, senha: @correntistum.senha }
    assert_redirected_to correntistum_path(assigns(:correntistum))
  end

  test "should destroy correntistum" do
    assert_difference('Correntistum.count', -1) do
      delete :destroy, id: @correntistum
    end

    assert_redirected_to correntista_path
  end
end
