# Homepage (Root path)
get '/' do
  erb :index
end

# Login
post "/login" do
  user = User.find_by(email: params[:email], password: params[:password])
  if user
    session[:user_id] = user.id
  else
    session[:error] = "Invalid email or password"
  end
  redirect '/'
end

get "/logout" do
  session.clear
  redirect '/'
end
