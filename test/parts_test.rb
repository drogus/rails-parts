require 'test_helper'
require 'parts/railtie'

class PartsTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    Rails.application
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

#  it "should render the html format by default to the controller that set it" do
#    controller = dispatch_to(Main, :index4)
#    controller.body.should match(/part_html_format/m)
#  end
#
#  it "should render the xml format according to the controller" do
#    controller = dispatch_to(Main, :index4, {:format => 'xml'} )
#    controller.body.should match(/part_xml_format/m)
#  end
#
#  it "should render the js format according to the controller" do
#    controller = dispatch_to(Main, :index4, :format => 'js')
#    controller.body.should match(/part_js_format/m)
#  end
#
#  it "should provide params when calling a part" do
#    controller = dispatch_to(Main, :part_with_params)
#    controller.body.should match( /my_param = my_value/)
#    controller.body.should match( /my_second_param = my_value/)
#  end
#
#  it "should provide arrays from params when calling a part" do
#    controller = dispatch_to(Main, :part_with_arrays_in_params)
#    controller.body.should match(/my_param = my_first_value, my_second_value/)
#    controller.body.should match( /my_second_param = my_value/)
#  end
#
#  it "should render from inside a view" do
#    controller = dispatch_to(Main, :part_within_view)
#    controller.body.should match( /Do this/)
#  end
#
#  it "should render a template from an absolute path" do
#    controller = dispatch_to(Main, :parth_with_absolute_template)
#    controller.body.should match(/part_html_format/m)
#  end
#
end

