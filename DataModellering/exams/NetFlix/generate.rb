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
  script = <<'END'
CREATE TABLE films
(
        id INTEGER NOT NULL PRIMARY KEY,
        titel VARCHAR(256) NOT NULL,
        jaar INT NOT NULL
);

CREATE TABLE gebruikers
(
        id INTEGER NOT NULL PRIMARY KEY,
        naam VARCHAR(256) NOT NULL,
        is_man BOOLEAN NOT NULL,
        geboortedatum DATE NOT NULL
);

CREATE TABLE bestellingen
(
        id INTEGER NOT NULL PRIMARY KEY,
        gebruiker_id INTEGER NOT NULL,
        film_id INTEGER NOT NULL,
        datum DATE NOT NULL,
        kost REAL NOT NULL,
        FOREIGN KEY(gebruiker_id) REFERENCES gebruikers(id),
        FOREIGN KEY(film_id) REFERENCES films(id)
);

CREATE TABLE beoordelingen
(
        gebruiker_id INTEGER NOT NULL,
        film_id INTEGER NOT NULL,
        score INTEGER NOT NULL,
        PRIMARY KEY (gebruiker_id, film_id),
        FOREIGN KEY (gebruiker_id) REFERENCES gebruikers(id),
        FOREIGN KEY (film_id) REFERENCES films(id)
);

CREATE TABLE acteurs
(
        id INTEGER NOT NULL PRIMARY KEY,
        naam VARCHAR(256) NOT NULL
);

CREATE TABLE films_acteurs
(
        film_id INTEGER NOT NULL,
        acteur_id INTEGER NOT NULL,
        PRIMARY KEY(film_id, acteur_id),
        FOREIGN KEY (film_id) REFERENCES films(id),
        FOREIGN KEY (acteur_id) REFERENCES acteurs(id)
);

CREATE TABLE leeftijdscategorieen
(
        ondergrens INTEGER NOT NULL,
        bovengrens INTEGER NOT NULL,
        PRIMARY KEY(ondergrens, bovengrens)
);
END

  script.split("\n\n").each do |sql|
    execute(sql)
  end
end

def add_movie(title, year)
  insert('films', { "titel" => "'#{title}'", "jaar" => year })
end

def add_user(name, birthdate, male)
  insert('gebruikers', { "naam" => "'#{name}'", "geboortedatum" => "'#{birthdate}'", "is_man" => if male then 1 else 0 end })
end

def add_order(userid, filmid, date, cost)
  insert('bestellingen', { "gebruiker_id" => userid, "film_id" => filmid, "datum" => "'#{date}'", "kost" => cost }, false)
end

def add_review(userid, filmid, score)
  insert('beoordelingen', { "gebruiker_id" => userid, "film_id" => filmid, "score" => score }, false)
end

def add_actor(name, movie_ids)
  actor_id = insert("acteurs", { "naam" => "'#{name}'" })

  movie_ids.each do |movie_id|
    insert('films_acteurs', { "film_id" => movie_id, "acteur_id" => actor_id }, false)
  end

  actor_id
end

def add_category(min, max)
  insert('leeftijdscategorieen', { "ondergrens" => min, "bovengrens" => max }, false)
end

def add_data
  boys = {}
  girls = {}

  (1..50).each do |age|
    boys[age] = add_user("boy #{age}", "#{2014-age}-01-01 00:00:00", true)
    girls[age] = add_user("girl #{age}", "#{2014-age}-01-01 00:00:00", false)
    girls[50+age] = add_user("girl #{50+age}", "#{2014-age-50}-01-01 00:00:00", false)
  end

  add_category(0, 5)
  add_category(6, 10)
  add_category(11, 18)
  add_category(19, 30)
  add_category(30, 100)

  magnolia = add_movie("Magnolia", 1999)
  ouatitw = add_movie("Once Upon a Time in the West", 1968)
  moulin_rouge = add_movie("Moulin Rouge!", 2001)
  big_fish = add_movie("Big Fish", 2003)
  mi3 = add_movie("Mission: Impossible 3", 2006)
  vita = add_movie("La Vita e Bella", 1563)
  pony = add_movie("My Little Pony", 1999)
  nemo = add_movie("Finding Nemo", 2000)
  
  add_order(boys[30], magnolia, "2/2/2000", 10)
  add_order(boys[30], ouatitw, "2/2/2000", 5)
  add_order(boys[30], moulin_rouge, "2/2/2000", 5)
  add_order(boys[30], moulin_rouge, "1/1/2001", 5)
  add_order(boys[30], moulin_rouge, "2/1/2001", 5)
  add_order(boys[30], moulin_rouge, "3/1/2001", 5)
  add_order(boys[30], moulin_rouge, "4/1/2001", 5)

  add_order(boys[29], magnolia, "2/2/2001", 9)
  add_order(boys[28], magnolia, "2/2/2002", 8)
  add_order(boys[27], magnolia, "3/3/2003", 5)
  add_order(boys[26], magnolia, "3/3/2003", 5)
  add_order(boys[25], big_fish, "3/3/2003", 3)

  (1..50).each do |age|
    add_review( boys[age], pony, 0 )
    add_review( girls[age], pony, if age <= 5 then 10 else 0 end )

    add_review( boys[age], vita, 0 )
    add_review( girls[age], vita, 10 )

    add_review( boys[age], nemo, 10 )
    add_review( girls[age], nemo, 8 )
  end

  add_actor("Jason Robards", [ magnolia, ouatitw ])
  add_actor("Tom Cruise", [ magnolia, mi3 ])
  add_actor("Ewan McGregor", [ moulin_rouge, big_fish ])
  add_actor("Philip Seymour Hoffman", [ moulin_rouge, mi3 ])
  add_actor("Roberto Benigni", [ vita ])
end




$db = SQLite3::Database.new( "test.db" )

create_tables
add_data

$db.close
