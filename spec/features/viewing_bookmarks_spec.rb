feature 'viewing bookmarks' do
  scenario 'bookmarks are visible' do
    visit '/bookmarks'
    expect(page).to have_content 'https://www.google.com'
    expect(page).to have_content 'https://www.amazon.co.uk'
  end
end
