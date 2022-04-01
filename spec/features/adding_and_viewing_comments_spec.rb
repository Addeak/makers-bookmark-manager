feature 'Adding and viewing comments' do
  feature 'A user can add and view comments' do
    scenario 'A comment is added to a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test bookmark')

      visit('/bookmarks')
      first('.bookmark').click_button 'Add Comment'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

      fill_in 'comment', with: 'Test comment'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'Test comment'
    end
  end
end
