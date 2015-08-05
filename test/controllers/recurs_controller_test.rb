require 'test_helper'

class RecursControllerTest < ActionController::TestCase
  setup do
    @recur = recurs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recur" do
    assert_difference('Recur.count') do
      post :create, recur: { daypattern: @recur.daypattern, enddate: @recur.enddate, false}: @recur.false}, frequency: @recur.frequency, latestdate: @recur.latestdate, nextdate: @recur.nextdate, recurs: @recur.recurs, todo_id: @recur.todo_id, {: @recur.{ }
    end

    assert_redirected_to recur_path(assigns(:recur))
  end

  test "should show recur" do
    get :show, id: @recur
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recur
    assert_response :success
  end

  test "should update recur" do
    patch :update, id: @recur, recur: { daypattern: @recur.daypattern, enddate: @recur.enddate, false}: @recur.false}, frequency: @recur.frequency, latestdate: @recur.latestdate, nextdate: @recur.nextdate, recurs: @recur.recurs, todo_id: @recur.todo_id, {: @recur.{ }
    assert_redirected_to recur_path(assigns(:recur))
  end

  test "should destroy recur" do
    assert_difference('Recur.count', -1) do
      delete :destroy, id: @recur
    end

    assert_redirected_to recurs_path
  end
end
