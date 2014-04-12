#!/usr/bin/ruby
require 'optparse'
require 'active_support/core_ext/string'
require 'benchmark'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: runner.rb [-t] PROBLEM_NAME FILENAME"

  opts.on("-t", "--[no-]test", "Run with benchmarking on") do |v|
    options[:test] = v
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end

end.parse!


raise "Please specify a problem name name and filename" if ARGV.length == 0
raise "Please specify a filename" if ARGV.length == 1

options[:filename] = ARGV.pop
options[:problem_name] = ARGV.pop

raise "The file #{options[:filename]} should have an extension .in" unless options[:filename].end_with? '.in'
raise "The file #{options[:filename]} doesn't exist" unless File.exists? options[:filename]


require "./#{options[:problem_name]}/#{options[:problem_name]}"

solver = options[:problem_name].classify.constantize.new

if options[:test]
  Benchmark.bm do |x|
    x.report(options[:problem_name]) { solver.solve_with_file(options[:filename]) }
  end
else
  solver.solve_with_file(options[:filename])
end
