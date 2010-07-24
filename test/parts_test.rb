require 'test_helper'
require 'parts/railtie'

class PartsTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    Rails.application
  end

  test "allow override default layout" do
    get "/main/override_default_layout"
    assert_equal "FOO\nother_part\nFOO\n", last_response.body
  end

  test "render a part with custom layout" do
    get "/main/with_custom_layout"
    assert_equal "FOO\nTODOPART\nDo this|Do that|Do the other thing\nTODOPART\nFOO\n", last_response.body
  end

  test "render a part template with no layout" do
    get "/main/index2"
    assert_equal "TODOPART\nDo this|Do that|Do the other thing\nTODOPART\n", last_response.body
  end

  test "render a part template with it's own layout" do
    get "/main/index"
    expected = "TODOLAYOUT\nTODOPART\nDo this|Do that|Do the other thing\nTODOPART\nTODOLAYOUT\n"
    assert_equal expected, last_response.body
  end

  test "render multiple parts if more then one part is passed in" do
    get "/main/index3"
    expected = "TODOPART\nDo this|Do that|Do the other thing\nTODOPART\n" +
               "TODOLAYOUT\nTODOPART\nDo this|Do that|Do the other thing\nTODOPART\nTODOLAYOUT\n"
    assert_equal expected, last_response.body
  end

  test "render the html format by default to the controller that set it" do
    get "/main/index4"
    assert_match /part_html_format/m, last_response.body
  end

  test "render the xml format according to the controller" do
    get "/main/index4.xml"
    assert_match /part_xml_format/m, last_response.body
  end

  test "render the js format according to the controller" do
    get "/main/index4.js"
    assert_match /part_js_format/m, last_response.body
  end

  test "provide params when calling a part" do
    get "/main/part_with_params"
    assert_match /my_param = my_value/, last_response.body
    assert_match /my_second_param = my_value/, last_response.body
  end

  test "provide arrays from params when calling a part" do
    get "/main/part_with_arrays_in_params"
    assert_match /my_param = my_first_value, my_second_value/, last_response.body
    assert_match /my_second_param = my_value/, last_response.body
  end

  test "render from inside a view" do
    get "/main/part_within_view"
    assert_match /Do this/, last_response.body
  end
end

