require 'test_helper'

class WebsitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @website = websites(:one)
  end

  test "should get index" do
    get websites_url
    assert_response :success
  end

  test "should get new" do
    get new_website_url
    assert_response :success
  end

  test "should create website" do
    assert_difference('Website.count') do
      post websites_url, params: { website: { about: @website.about, account_id: @website.account_id, domain_url: @website.domain_url, facebook: @website.facebook, google_analytics: @website.google_analytics, name: @website.name, tags: @website.tags, twitter: @website.twitter } }
    end

    assert_redirected_to website_url(Website.last)
  end

  test "should show website" do
    get website_url(@website)
    assert_response :success
  end

  test "should get edit" do
    get edit_website_url(@website)
    assert_response :success
  end

  test "should update website" do
    patch website_url(@website), params: { website: { about: @website.about, account_id: @website.account_id, domain_url: @website.domain_url, facebook: @website.facebook, google_analytics: @website.google_analytics, name: @website.name, tags: @website.tags, twitter: @website.twitter } }
    assert_redirected_to website_url(@website)
  end

  test "should destroy website" do
    assert_difference('Website.count', -1) do
      delete website_url(@website)
    end

    assert_redirected_to websites_url
  end
end
