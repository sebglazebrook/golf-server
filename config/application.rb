require "sinatra"
require "pathname"

PROJECT_ROOT = Pathname.new(File.expand_path(File.join("..", ".."), __FILE__))
$LOAD_PATH.unshift(PROJECT_ROOT.join("lib"))

require "golf_server"
