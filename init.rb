#-*- encoding: utf-8
=begin
<CAUTION>
drop and initialize sqlite3 tables.
=end

require 'sqlite3'

def DropTable(db)
  begin
    db.execute("drop table user_table;")
    db.execute("drop table account_table;")
    db.execute("drop table debit_table;")
    db.execute("drop table credit_table;")
    db.execute("drop table account_by_credit_table;")
    db.execute("drop table account_by_debit_table;")
  rescue SQLite3::SQLException
    # nop
  end
end

def CreateTable(db)
  db.execute("create table user_table (userid integer primary key, username text not null);")
  account_sql = <<END
  create table account_table (
    id integer primary key autoincrement,
    userid integer not null,
    date text not null,
    summary text);
END
  db.execute(account_sql)
  db.execute("create table debit_table (id integer primary key autoincrement, item_name text not null);")
  db.execute("create table credit_table (id integer primary key autoincrement, item_name text not null);")
  db.execute("create table account_by_credit_table (account_id integer not null, credit_id integer not null, cache integer not null);")
  db.execute("create table account_by_debit_table (account_id integer not null, debit_id integer not null, cache integer not null);")
end

def MakeTestUser(db)
  db.execute("insert into user_table values (0, ?)", ["TEST_USER"])
end

db = SQLite3::Database.new("accounts.db")
DropTable(db)
CreateTable(db)
MakeTestUser(db)
db.close