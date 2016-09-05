require 'rails_helper'

logger = User.logger

RSpec.describe User, type: :model do
  def create_user
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
   self.create_user
   expect(@user.accounts.count).to eq(1)
   expect(@user.account_users.first.role).to eq('Owner')
  end

  it "creates website on register" do
    self.create_user
    expect(@user.websites.count).to eq(1)
    expect(@user.websites.first.name).to eq(@website_name)
    expect(@user.websites.first.domain_url).to eq(@website_domain)
  end

  it "does not create a new account if one exists" do
    account = Account.new
    account.save!
    puts account.id
    user = User.create(name: 'Dan',
                        email: 'something+2@email.com',
                        password: 'abc123',
                        password_confirmation: 'abc123',
                        assign_account_id:  account.id,
                        website_name: @website_name,
                        website_domain: @website_domain)

    expect(user.accounts.count).to eq(1)
    expect(user.account_users.first.role).to eq('Editor')
  end

end
