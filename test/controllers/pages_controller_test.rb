require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "A not-logged-in user can see no pages" do
    session[:user_id] = nil # Ensure no one is logged in

    # Send the request and check the response
    get :index
    assert_redirected_to login_path
  end

  test "A logged-in user can see exactly her pages" do
    session[:user_id] = users(:grace).id

    # Send the request and check the response
    get :index
    assert_response :success
    assert_template 'pages/index'

    # Confirm that we got exactly the pages we expected
    # This means the following:
    #   - All pages returned belong to the user
    #   - All pages belonging to the user were returned
    pages = assigns(:pages)
    assert_equal pages.length, users(:grace).pages.length
    pages.each do |page|
      assert_equal page.user_id, users(:grace).id
      assert_includes users(:grace).pages, page
    end
  end

  test "A user with no pages should see no pages" do
    # Make your assumptions explicit
    assert_equal users(:no_pages_user).pages.length, 0
    session[:user_id] = users(:no_pages_user).id

    # Send the request and check the response
    get :index
    assert_response :success
    assert_template 'pages/index'

    # Confirm that we got no pages
    pages = assigns(:pages)
    assert_equal pages.length, 0
  end
end
