require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "the tests" do
    Page.all.each do |page|
      puts "    Page #{page.id} by #{page.user.name}, title #{page.title}"
    end
    assert true
  end
end
