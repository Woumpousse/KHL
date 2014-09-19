ARGV.each do |dir|
  Dir.chdir( dir ) do
    result = IO.readlines('export').each do |pattern|
      Dir[ pattern.strip ].each do |entry|
        puts "#{dir}/#{entry}"
      end
    end
  end
end
