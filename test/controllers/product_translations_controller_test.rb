require 'test_helper'

class ProductTranslationsControllerTest < ActionController::TestCase
  setup do
    @product_translation = product_translations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_translations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_translation" do
    assert_difference('ProductTranslation.count') do
      post :create, product_translation: { description: @product_translation.description, language_id: @product_translation.language_id, price: @product_translation.price, product_id: @product_translation.product_id, title: @product_translation.title }
    end

    assert_redirected_to product_translation_path(assigns(:product_translation))
  end

  test "should show product_translation" do
    get :show, id: @product_translation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_translation
    assert_response :success
  end

  test "should update product_translation" do
    patch :update, id: @product_translation, product_translation: { description: @product_translation.description, language_id: @product_translation.language_id, price: @product_translation.price, product_id: @product_translation.product_id, title: @product_translation.title }
    assert_redirected_to product_translation_path(assigns(:product_translation))
  end

  test "should destroy product_translation" do
    assert_difference('ProductTranslation.count', -1) do
      delete :destroy, id: @product_translation
    end

    assert_redirected_to product_translations_path
  end
end
