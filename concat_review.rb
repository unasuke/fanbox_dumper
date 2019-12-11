require 'time'
files = Dir.glob('sandbox/**/*.re').sort.reject { |f| f.include?('_trimed.re') }
BASEDIR = 'sandbox/'

start_month = Date.parse('2018-05-01')

def shift_2level(string)
  string.gsub(%r[^=], '===')
end

(2018..2019).each do |year|
  (1..12).each do |month|
    File.open("%04d-%02d.re" % [year, month], 'w') do |f|
      f.write "= %04d-%02d \n" % [year, month]
      (1..31).each do |day|
        f.write "== %04d-%02d-%02d \n" % [year, month, day]

        dir = BASEDIR + Date.parse("#{year}-#{month}-#{day}").to_s
        next unless Dir.exists?(dir)
        files = Dir.glob("#{dir}/*_trimed.re").sort

        ['Rails', 'Mastodon'].each do |special|
          cursor = files.find_index { |e| e.include?(special) }
          next if cursor.nil?

          target_file = files[cursor]
          target_body = File.read(target_file)
          f.write shift_2level(target_body) + "\n"

          files.delete_at(cursor)
        end

        files.each do |other|
          target_body = File.read(other)
          f.write shift_2level(target_body) + "\n"
        end
      rescue Date::Error
        next
      end
    end
  end
end
