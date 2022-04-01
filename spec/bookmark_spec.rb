require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy All Software")
      Bookmark.create(url: "http://www.google.com", title: "Google")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test bookmark')
      persisted_data = persisted_data(id: bookmark.id)
      
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.url).to eq 'http://www.example.org'
      expect(bookmark.title).to eq 'Test bookmark'
    end

    it 'does not create a bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real url', title: 'not a real bookmark')

      expect(Bookmark.all).to be_empty
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test bookmark')
      Bookmark.delete(id: bookmark.id)
      bookmarks = Bookmark.all

      expect(bookmarks.empty?).to eq true
    end
  end

  describe '.update' do
    it 'updates an existing bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test bookmark')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.differentexample.com', title: 'Different test bookmark')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Different test bookmark'
      expect(updated_bookmark.url).to eq 'http://www.differentexample.com'
    end
  end

  describe '.find' do
    it 'returns a requested bookmark object' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test bookmark')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Test bookmark'
      expect(result.url).to eq 'http://www.example.org'
    end
  end

  describe '#comments' do
    it 'returns a list of comments on the bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Test bookmark')
      DatabaseConnection.query(
        "INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', $1)",
        [bookmark.id]
      )

      comment = bookmark.comments.first
      
      expect(comment['text']).to eq "Test comment"
    end
  end
end
