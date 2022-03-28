feature 'test' do
  scenario 'checking setup' do
    visit '/'
    expect(page).to have_content 'Bookmark Manager'
  end
end
