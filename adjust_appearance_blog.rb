require 'tty-prompt'

files = Dir.glob('sandbox/**/*.re').sort.reject { |f| f.include?('_trimed.re') }
prompt = TTY::Prompt.new

files.each do |file|
  dir = File.dirname(file) + '/'
  name = File.basename(file, '.re') + '_trimed.re'
  dest_name = dir + name

  if File.exist?(dest_name)
    prompt.ok("#{file} was trimed. Skip this.")
    next
  end

  body = File.read(file)

  body = body.gsub(%r[@<href>{/fanbox/manage/post/\d+/edit,編集}\n], '')
    .gsub(%r[^\d{4}年\d+月\d+日 \d{2}:\d{2}$], '')
    .gsub(%r[^¥\d+\n$], '')
    .gsub(%r[^全体公開\n$], '')
    .gsub(%r[^・$], '')
    .gsub(%r[^・], '== ')
    .gsub(%r[^\n$], '')
    .gsub(%r[^@<href>{(?<url>https://.+?),(?<title>(?~http|//))?}$]) {
      "== #{$~[:title]}\n@<href>{#{$~[:url]},#{$~[:url]}}"
    }

  print body

  begin
    if prompt.yes?('Apply?')
      File.open(dir + name, 'w') do |f|
        f.write body
      end

      prompt.ok("Saved to #{dir + name}")
    end
  rescue TTY::Reader::InputInterrupt
    prompt.error('Interrupted')
    exit
  ensure
    prompt.warn"=============================================\n============================================="
  end
end

prompt.ok("Done")
