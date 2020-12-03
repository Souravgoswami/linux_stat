#!/usr/bin/env ruby
# Run:
# ruby linux_stat.rb --md | ruby linux_stat_md_to_html.rb

ind = 0

STDIN.read.each_line.each_with_index do |x, i|
	stripped = x.strip

	p = if stripped[/^\#{3}.*$/]
		"<h3>#{stripped[3..-1].strip}</h3>"
	elsif stripped[/^```$/]
		ind += 1
		ind.odd? ? "<pre>" : "</pre>"
	else
		"\t#{x}"
	end

	puts "\t#{p}"
end
