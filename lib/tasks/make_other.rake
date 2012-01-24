desc "Make Other"
task :make_other => :environment do
	require 'rubygems'
	assign_categories
	assign_categories_2
	national
end