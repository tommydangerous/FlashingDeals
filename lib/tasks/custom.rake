desc "Custom test rake"
task :test => :environment do
	custom
end

def custom
	puts "hope this work"
end