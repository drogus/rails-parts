require 'test_helper'
require 'parts/railtie'

class FooController < ActionController::Base
  layout false

  def index
    #render :text => part(TestPart => :index, :bla => 'bla')
    render :inline => "<%= part TestPart => :index, :bla => 'bla' %>"
  end
end

class TestPart < Parts::Part::Base
  append_view_path "test/dummy/app/parts/views"
  def index
    render :text => params[:bla]
  end
end

class PartsTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  Rails.application.routes.draw do
    match "/foo" => "foo#index"
  end

  def app
    Rails.application
  end

  def test_action_with_part
    get "/foo"
    assert_equal "bla", last_response.body
  end
end
