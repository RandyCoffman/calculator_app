require "sinatra"
require_relative "add.rb"
require_relative "subtract.rb"
require_relative "multi.rb"
require_relative "div.rb"

enable :sessions

get "/" do
	erb :first_page, locals:{error: ""}
end

post "/user" do
	username = params[:username]
	password = params[:password]
	if username == "Scott" && password == "Coffman"
		redirect "/ask_name?username=" + username
	elsif username == "Mined" && password == "Minds"
		redirect "/ask_name?username=" + username
	elsif username == "Bruce" && password == "Wayne"
		redirect "/ask_name?username=" + username
	else 
		error = "Wrong Username and Password combination"
		erb :first_page, locals:{error: "Wrong Username and Password combination"}
	end
end

get "/ask_name" do
	username = params[:username]
	erb :second_page, locals:{username: username}
end

post "/name" do
	username = params[:username]
	n_name = params[:n_name]
	redirect "/name_redirect?username=" + username + "&n_name=" + n_name
end

get "/name_redirect" do
	username = params[:username]
	n_name = params[:n_name]
	number = params[:number]
	othernumber = params[:othernumber]
	erb :third_page, locals:{username: username, n_name: n_name, quick_math: session[:quick_math], number: number, othernumber: othernumber}
end

post "/calculator" do
	username = params[:username]
	n_name = params[:n_name]
	number = params[:number]
	othernumber = params[:othernumber]
	if session[:quick_math] == "+"
        results = add(number.to_i, othernumber.to_i)
    elsif session[:quick_math] == "-"
        results = subtract(number.to_i, othernumber.to_i)
    elsif session[:quick_math] == "*"
        results = multi(number.to_i, othernumber.to_i)
    elsif session[:quick_math] == "/"
        results = div(number.to_i, othernumber.to_i)
    end
    redirect "results?username=" + username + "&n_name=" + n_name + "&number=" + number + "&othernumber=" + othernumber + "&results=" + results
end

get "/results" do
	username = params[:username]
	n_name = params[:n_name]
	number = params[:number]
	othernumber = params[:othernumber]
	results = params[:results]
erb :final_page, locals:{username: username, n_name: n_name, quick_math: session[:quick_math], number: number, othernumber: othernumber}
end
