require 'rails_helper'

describe 'User visits url host', :type => :feature do

  it 'they see are presented with the correct website' do
    website = Website.create!(account: Account.new, name: 'Test Site', domain_url: 'another.dev', theme: 'basic')
    # visit '/'
    # visit '/sessions/new'
    # within("#session") do
    #   fill_in 'Email', :with => 'user@example.com'
    #   fill_in 'Password', :with => 'password'
    # end
    # click_button 'Sign in'
    # expect(page).to have_content 'Success'
  end

end
