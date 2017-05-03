require "bundler/setup"
require "git"

@config = eval(File.open('config.rb') {|f| f.read })

g = Git.open(@config[:repository_path])

g.config('user.name', @config[:git][:username])
g.config('user.email', @config[:git][:email])

puts 'git pull...'
g.pull

puts 'executing command...'
command = "cd #{@config[:repository_path]} && " + @config[:command]
# puts command
system(command)

puts "git checkout #{@config[:branch]}"
g.checkout(@config[:branch])
if not g.diff.to_s.empty?
	puts 'changes found'
	g.add(:all => true)
	g.commit(@config[:message])
	puts 'pushing...'
	g.push(g.remote(@config[:remote]), @config[:branch])
	puts 'done'
else
	puts 'nothing changed'
end

