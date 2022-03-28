feature 'test' do
  scenario 'checking setup' do
    visit '/'
    expect(page).to have_content 'Hello world'
  end
end
