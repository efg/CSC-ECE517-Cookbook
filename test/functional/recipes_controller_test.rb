require 'test_helper'

class RecipesControllerTest < ActionController::TestCase
  setup do
    @recipe = recipes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recipes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recipe" do
    assert_difference('Recipe.count') do
      post :create, params: { recipe: { description: @recipe.description, instructions: @recipe.instructions, title: @recipe.title, category_id: @recipe.category_id } }
    end

    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should show recipe" do
    get :show, params: { id: @recipe }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @recipe }
    assert_response :success
  end

  test "should update recipe" do
    put :update, params: { id: @recipe, recipe: { description: @recipe.description, instructions: @recipe.instructions, title: @recipe.title } }
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete :destroy, params: { id: @recipe }
    end

    assert_redirected_to recipes_path
  end
end
