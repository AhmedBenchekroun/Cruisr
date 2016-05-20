# Homepage (Root path)
helpers do
  def current_user
    session[:id] ? @current_user = CrewMember.find(session[:id]) : nil
  end
end

get '/' do
  erb :index
end

get '/signin_signup' do
  erb :'signin_signup'
end

get '/voyages' do
  @voyages = Voyage.all
  @crew_member = @current_user
  erb :'voyages'
end

# get '/voyages/:id' do
#   @voyage = Voyage.find params[:id]
#   @other_voyages = Voyage.where()
#   erb :'voyages/show'
# end

get '/ports' do
  @voyages = Port.all
  erb :'ports/index'
end

get '/matches' do
  erb :'voyages/matches/index'
end

post '/login' do
  @user = CrewMember.find_by_email(params[:email]).try(:authenticate, params[:password])
  if @user
    session[:id] = @user.id
    redirect '/voyages'
  else
    @error = 'Wrong email'
    erb :index
  end
end

post '/register' do
  @user = CrewMember.find_by_email(params[:email])
  if @user
    @error = "Email already exists"
    erb :index
  else
    @user = CrewMember.create(
    full_name: params[:full_name],
    nationality: params[:nationality],
    date_of_birth: params[:date_of_birth],
    email: params[:email],
    password: params[:password], password_confirmation: params[:password_confirmation])
    redirect '/voyages'

  end
end

get '/logout' do
  session[:id] = nil
  redirect '/'
end










