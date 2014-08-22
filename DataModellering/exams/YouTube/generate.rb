require 'sqlite3'

def execute(sql)
  puts sql
  puts ""

  if block_given? then
    $db.execute(sql) do |*args|
      yield(*args)
    end
  else
    $db.execute(sql)
  end
end

def first_value(sql)
  $db.get_first_value(sql)
end

def insert(table, fields, getid = true)
  cols = fields.keys
  vals = cols.map { |col| fields[col] }

  cols = cols.map { |x| x.to_s }.join(", ")
  vals = vals.map { |x| x.to_s }.join(", ")

  execute( "insert into #{table}(#{cols}) values (#{vals});" )

  condition = fields.to_a.map do |col, val|
    "#{col} = #{val}"
  end.join(" AND ")

  sql = "select id from #{table} where #{condition};"
  if getid
  then first_value( sql )
  else nil
  end
end

def create_tables
  script = IO.read('create.sql')

  script.split("\n\n").each do |sql|
    execute(sql)
  end
end

def add_user(name, birthdate, male, country)
  insert('gebruikers', {
           "naam" => "'#{name}'",
           "geboortedatum" => "'#{birthdate}'",
           "is_man" => if male then 1 else 0 end,
           "land" => "'#{country}'"
         })
end

def add_movie(title, year, uploader, length)
  insert('filmpjes', { "titel" => "'#{title}'", "jaar" => "'#{year}'", "uploader" => uploader, "lengte_in_seconden" => length })
end

def add_view(movieid, userid, datetime)
  insert('views', { "film_id" => movieid, "gebruiker_id" => userid, "datum_uur" => "'#{datetime}'" }, false)
end

def add_vote(movieid, userid, upvote)
  insert('votes', { "film_id" => movieid, "gebruiker_id" => userid, "upvote" => if upvote then 1 else 0 end }, false)
end

def add_comment(movieid, userid, datetime, comment)
  insert('comments', { "film_id" => movieid, "gebruiker_id" => userid, "datum_uur" => "'#{datetime}'", "commentaar" => "'#{comment}'" }, false)
end

def add_playlist(userid, name, pub, movies)
  playlistid = insert('playlists', { "eigenaar" => userid, "naam" => "'#{name}'", "publiek" => if pub then 1 else 0 end })

  movies.each do |movieid|
    insert('filmpjes_playlists', { "playlist_id" => playlistid, "film_id" => movieid }, false)
  end

  playlistid
end


def add_data
  boys = {}
  girls = {}

  countries = %w(Belgium UK France Germany USA Japan)

  (1..20).each do |age|
    boys[age] = add_user("boy #{age}", "#{2014-age}-01-01 00:00:00", true, countries[age % countries.length])
    girls[age] = add_user("girl #{age}", "#{2014-age}-01-01 00:00:00", false, countries[age % countries.length])
  end

  movies_m = (1..10).map do |idx|
    add_movie("Movie M #{idx}", "#{2014-idx}-01-01 00:00:00", boys[idx], idx * 60)
  end

  movies_f = (1..10).map do |idx|
    add_movie("Movie F #{idx}", "#{2014-idx}-01-01 00:00:00", girls[idx], idx * 60)
  end

  boys.values.each do |userid|
    movies_m.each do |movieid|
      add_vote(movieid, userid, true)
    end
  end

  girls.values.each do |userid|
    movies_m.each do |movieid|
      add_vote(movieid, userid, false)
    end

    movies_f.each do |movieid|
      add_vote(movieid, userid, true)
    end
  end

  boys.values.each do |userid|
    add_view(movies_m[0], userid, "2014-01-01 00:00:00")
  end

  girls.values.each do |userid|
    movies_f.each do |movieid|
      add_view(movieid, userid, "2014-01-01 00:00:00")
    end
  end

  add_playlist(boys[10], 'my movies B10', true, movies_m[0..4])
  add_playlist(boys[11], 'my movies B11', true, [movies_m[0]])
  add_playlist(boys[12], 'my movies B12', true, movies_m[0..8])

  add_playlist(boys[10], 'my private movies B10', false, movies_f[0..8])
  add_playlist(boys[11], 'my private movies B11', false, movies_f[0..8])
  add_playlist(boys[12], 'my private movies B12', false, movies_f[0..8])
  add_playlist(boys[13], 'my private movies B13', false, movies_f[0..8])

  movies_m.each do |movieid|
    (10..16).each do |age|
      add_comment(movieid, boys[age], "2014-01-01 00:00:00", 'comment')
    end
  end
end


$db = SQLite3::Database.new( "test.db" )

create_tables
add_data

$db.close
