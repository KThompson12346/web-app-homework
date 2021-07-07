require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require "pry"
require_relative "./controller/controller.rb"

# Direct request to the correct controller
use Rack::Reloader
use Rack::MethodOverride
run Controller
