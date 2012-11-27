#-*- encoding: utf-8
=begin
<CAUTION>
drop and initialize sqlite3 tables.
=end

require 'sqlite3'

def DropTable(db)
  db.execute("drop table user_table")
  db.execute("drop table account_table")
end

def CreateTable(db)
  db.execute("create table user_table (userid integer primary key, username text);")
  db.execute("")
end

db = SQLite3::Database.new("accounts.db")
  DropTable(db)
  
db.close