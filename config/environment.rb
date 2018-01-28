require 'bundler'
require 'benchmark'

$stdout.print 'Loading Bundler: '
bm = Benchmark.measure { |_| Bundler.setup }
$stdout.print "loaded in #{bm.total.round(3)}s\n"

root_path = File.join(File.dirname(__FILE__),'..')
lib_path = File.join(root_path,'lib')
app_name = 'bitmap_editor'

$LOAD_PATH << root_path
$LOAD_PATH << lib_path
$LOAD_PATH << File.join(lib_path, app_name)
require app_name