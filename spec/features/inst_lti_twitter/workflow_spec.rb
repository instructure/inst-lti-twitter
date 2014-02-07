require 'spec_helper'

describe 'Workflow', type: :request do #, js: true do
  it 'app should be accessible via POST' do
    visit '/twitter_lti/test/backdoor'
    click_button('Submit')
    page.should have_css('div#list')
  end
end

