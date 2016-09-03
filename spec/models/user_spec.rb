require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @website_name = 'Testing Website'
    @website_domain = 'example.com'
    @user = User.create(name: 'Dan',
                        email: 'something@email.com',
                        password: 'abc123',
                        password_confirmation: 'abc123',
                        website_name: @website_name,
                        website_domain: @website_domain)
  end

  it "creates account on register" do
   expect(@user.accounts.count).to eq(1)
  end

  it "creates website on register" do
    expect(@user.websites.count).to eq(1)
    expect(@user.websites.first.name).to eq(@website_name)
    expect(@user.websites.first.domain_url).to eq(@website_domain)
  end

end
