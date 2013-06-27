require 'eventmachine'
require 'yaml'
require 'json'
require 'sqlite3'
$home_dir = File.dirname(__FILE__)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

$config = YAML.load_file(File.dirname(__FILE__) + '/config.yml')

$triggers = Hash.new
$on_actives = Hash.new([])
$commands = Array.new

def on(*args, &block)
	case args[0]
	when :cmd
		args.shift
		args.each do |arg|
			$commands.push(arg)
			regex = /^\.#{arg} (.*)/
			$triggers[regex] = block
		end

	when :regex
		args.shift
		args.each do |arg|
			$triggers[arg] = block
		end

	when :active
		args.shift
		timestamp = args[0]
		args.shift
		args.each do |arg|
			if $on_actives.keys.include?(arg)
				$on_actives[arg].push([block, timestamp])
			else
				$on_actives[arg] = [[block, timestamp]]
			end
		end
	end
end

Dir[File.dirname(__FILE__) + '/modules/*.rb'].each {|file| load file }

EM.run do
	q = EM::Queue.new

	EM.connect $config['server'], $config['port'], Scriby, q
	EM.open_keyboard(KeyboardHandler, q)
end