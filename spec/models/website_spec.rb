require 'rails_helper'

def create_website(url)
  website = Website.create(account: Account.new, name: 'Test Site', domain_url: url, theme: 'basic')
  return website
end

RSpec.describe Website, type: :model do
  it "does not allow for duplicate website hosts without www" do
    website1 = create_website('www.test.com')
    website2 = create_website('test.com')
    expect(website1.id.present?).to eq(true)
    expect(website2.id.present?).to eq(false)
  end

  it "does not allow for duplicate website hosts with www" do
    website1 = create_website('test.com')
    website2 = create_website('www.test.com')
    expect(website1.id.present?).to eq(true)
    expect(website2.id.present?).to eq(false)
  end

  it "allows blank domain_url" do
    website1 = create_website('')
    expect(website1.id.present?).to eq(true)
  end

end
