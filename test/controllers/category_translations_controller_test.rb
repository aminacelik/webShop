require 'test_helper'

class CategoryTranslationsControllerTest < ActionController::TestCase
  setup do
    @category_translation = category_translations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:category_translations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category_translation" do
    assert_difference('CategoryTranslation.count') do
      post :create, category_translation: { category_id: @category_translation.category_id, language_id: @category_translation.language_id, name: @category_translation.name }
    end

    assert_redirected_to category_translation_path(assigns(:category_translation))
  end

  test "should show category_translation" do
    get :show, id: @category_translation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category_translation
    assert_response :success
  end

  test "should update category_translation" do
    patch :update, id: @category_translation, category_translation: { category_id: @category_translation.category_id, language_id: @category_translation.language_id, name: @category_translation.name }
    assert_redirected_to category_translation_path(assigns(:category_translation))
  end

  test "should destroy category_translation" do
    assert_difference('CategoryTranslation.count', -1) do
      delete :destroy, id: @category_translation
    end

    assert_redirected_to category_translations_path
  end
end
