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

def quote(str)
  "'#{str}'"
end

def add_customer(name)
  street = 'x'
  housenr = 1
  zip = '100x'
  city = 'y'

  insert('klanten', {
           'naam' => quote(name),
           'straat' => quote(street),
           'huisnr' => housenr,
           'postcode' => quote(zip),
           'stad' => quote(city)
         } )
end


def add_component(description, warranty, price)
  brand = 'x'

  insert('componenten', {
           'merk' => quote(brand),
           'omschrijving' => quote(description),
           'garantie' => warranty,
           'prijs' => price
         } )
end


def add_mobo(warranty, price, socket, ram)
  id = add_component("MB#{socket}-#{ram}", warranty, price)

  insert('moederborden', {
           'id' => id,
           'cpu_socket' => quote(socket),
           'ram_type' => quote(ram)
         } )
end

def add_cpu(warranty, price, socket)
  id = add_component("CPU#{socket}", warranty, price)

  insert('processoren', {
           'id' => id,
           'cpu_socket' => quote(socket)
         } )
end

def add_ram(warranty, price, type)
  id = add_component("RAM#{type}", warranty, price)

  insert('geheugen', {
           'id' => id,
           'ram_type' => quote(type)
         } )
end

def add_pc(warranty, price, mobo, cpu, ram)
  id = add_component("PC#{mobo}#{cpu}#{ram}", warranty, price)

  insert('computers', {
           'id' => id,
           'moederbord' => mobo,
           'processor' => cpu,
           'ram' => ram
         } )
end

def add_order( customer, items )
  id = insert('bestellingen', {
                'klantid' => customer,
                'datum' => quote('1/1/2000')
              } )

  items.each do |item|
    insert('componenten_bestellingen', {
             'bestelling_id' => id,
             'component_id' => item
           }, get_id = false )
  end
end

def add_data
  griet = add_customer('Griet')
  patrick = add_customer('Patrick')
  merel = add_customer('Merel')

  sockets = ['A', 'B', 'C']
  ram_types = [ 'DDR', 'DDR2', 'DDR3' ]

  mobos = {}
  rams = {}
  cpus = {}

  sockets.each_with_index do |socket, i|
    id = add_cpu(2, (i + 1) * 100, socket)

    cpus[socket] = id
  end

  ram_types.each_with_index do |ram, i|
    id = add_ram(5, (i + 1) * 60, ram)

    rams[ram] = id
  end

  sockets.each_with_index do |socket, i|
    ram_types.each_with_index do |ram, j|
      mobo_id = add_mobo(3, 40 * (i + j + 1), socket, ram)
      mobos[socket + ram] = mobo_id

      id = add_pc(2, 200 + 100 * (i + j + 1), mobo_id, cpus[socket], rams[ram])
    end
  end

  mobos['XDDR'] = add_mobo(3, 100, 'X', 'DDR')
  mobos['ADDR4'] = add_mobo(3, 200, 'A', 'DDR4')

  customers = [ 'a', 'b', 'c', 'd' ].map { |name| add_customer( name ) }

  
  add_order( customers[0], mobos.values )
  add_order( customers[1], cpus.values )
  add_order( customers[2], rams.values )

end



$db = SQLite3::Database.new( "test.db" )

create_tables
add_data

$db.close
