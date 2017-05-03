@config = eval(File.open('config.rb') {|f| f.read })

every 1.day, :at => @config[:scheduleTime] do
  command 'ruby ' + File.join(Dir.pwd, 'ciel.rb')
end
