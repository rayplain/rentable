require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)
  end

  test "should get index without search term" do
    get properties_url
    assert_response :success
    assert_not_nil assigns(:properties)
  end

  test "should get index with search term" do
    get properties_url, params: { search: @property.city }
    assert_response :success
    assert_not_nil assigns(:properties)
    assert_includes assigns(:properties), @property
  end

  test "should paginate the properties" do
    get properties_url
    assert_response :success
    assert_equal assigns(:properties).length, 10
  end

  private

  def properties
    @properties ||= Property.all
  end
end