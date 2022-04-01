require 'pg'

def setup_test_databse
  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE bookmarks, comments RESTART IDENTITY;")
end
