feature 'editing bookmarks' do
  scenario 'a user can edit an existing bookmark' do
    bookmark = Bookmark.create(url: "http://www.example.org", title: 'Test bookmark')
    visit('/bookmarks')
    expect(page).to have_link('Test bookmark', href: "http://www.example.org")

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: "http://www.differentexample.com")
    fill_in('title', with: 'Different test bookmark')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Test bookmark', href: "http://www.example.org")
    expect(page).to have_link('Different test bookmark', href: "http://www.differentexample.com")
  end
end
