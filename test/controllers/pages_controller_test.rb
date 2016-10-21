require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "not-logged-in user should get redirected from pages" do
    session.delete(:user_id)
    get :index
    assert_response :redirect
    assert_redirected_to login_path
  end

  test "Logged in user can see exactly her pages" do
    session[:user_id] = users(:grace).id

    # Send the request, check the response
    get :index
    assert_response :success
    assert_template "pages/index"

    # Check that pages match exactly, that is:
    #   - Pages owned by this user are returned
    #   - Pages not owned by this user are not returned
    pages_from_controller = assigns(:pages)
    assert_equal pages_from_controller.length, users(:grace).pages.length

    pages_from_controller.each do |page|
      assert_includes users(:grace).pages, page
    end
  end
end
