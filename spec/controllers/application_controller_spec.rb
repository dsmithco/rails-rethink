require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  def create_website(url)
    website = Website.create!(account: Account.new, name: 'Test Site', domain_url: url, theme: 'basic')
    return website
  end

  it "find_website for request with_www" do
    website = create_website('www.test.com')
    expect(website.id).to eq(controller.find_website('test.com').id)
    expect(website.id).to eq(controller.find_website('www.test.com').id)
  end

  it "find_website for request without_www" do
    website = create_website('test.com')
    expect(website.id).to eq(controller.find_website('test.com').id)
    expect(website.id).to eq(controller.find_website('www.test.com').id)
  end

end
