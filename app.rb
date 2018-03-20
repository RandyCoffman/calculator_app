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
	session[:username] = params[:username]
	password = params[:password]
	if username == "Scott" && password == "Coffman"
		redirect "/ask_name"
	elsif username == "Mined" && password == "Minds"
		redirect "/ask_name"
	elsif username == "Bruce" && password == "Wayne"
		redirect "/ask_name"
	else 
		error = "Wrong Username and Password combination"
		erb :first_page, locals:{error: "Wrong Username and Password combination"}
	end
end

get "/ask_name" do
	username = session[:username]
	erb :second_page, locals:{username: username}
end

post "/name" do
	session[:n_name] = params[:n_name]
	redirect "/name_redirect"
end

get "/name_redirect" do
	n_name = session[:n_name]
	number = params[:number]
	othernumber = params[:othernumber]
	erb :third_page, locals:{n_name: n_name, quick_math: session[:quick_math], number: number, othernumber: othernumber}
end

post "/calculator" do
	number = params[:number]
	othernumber = params[:othernumber]
	session[:quick_math] = params[:quick_math] #
	if session[:quick_math] == "+"
        session[:results] = add(number.to_f, othernumber.to_f)
    elsif session[:quick_math] == "-"
        session[:results] = subtract(number.to_f, othernumber.to_f)
    elsif session[:quick_math] == "*"
        session[:results] = multi(number.to_f, othernumber.to_f)
    elsif session[:quick_math] == "/"
        session[:results] = div(number.to_f, othernumber.to_f)
    end
    redirect "/results?" + "&number=" + number + "&othernumber=" + othernumber
end

get "/results" do
	number = params[:number]
	othernumber = params[:othernumber]
erb :final_page, locals:{quick_math: session[:quick_math], number: number, othernumber: othernumber, results:session[:results]}
end

post "/return" do
	n_name = session[:n_name]
    redirect "/name_redirect?"
end