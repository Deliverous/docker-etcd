require "test/unit"
require "capybara"
 
class TestEtcd < Test::Unit::TestCase
  include Capybara::DSL

  setup do
    Capybara.run_server = false
    Capybara.default_driver = :selenium
    Capybara.javascript_driver = :webkit
    Capybara.app_host = "http://localhost:4001"


  end

  test "landing page is responding" do
    visit '/'
    assert page.has_title? "Deliverous"
  end
end