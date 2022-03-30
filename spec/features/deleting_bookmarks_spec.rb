feature 'deleting bookmarks' do
  scenario 'a user can delete a bookmark' do
    visit '/bookmarks/new'
    fill_in('url', with: 'http://www.example.org')
    fill_in('title', with: 'Test bookmark')
    click_button 'Submit'
    click_button 'Delete bookmark'
    expect(page).not_to have_link('Test bookmark', href: 'http://www.example.org')
  end
end
