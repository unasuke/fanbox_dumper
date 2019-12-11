files = Dir.glob('*.re')

files.each do |file|
  body = File.read(file)

  body = body.gsub(%r[^(?<level>=+)\s(?<title>.+)$]) {
      "#{$~[:level]} {#{$~[:title]}}"
    }

  File.open('labeled_' + file, 'w') do |f|
    f.write body
  end
end
