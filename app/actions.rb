get '/friends' do
  erb :'voyages/friends'
end


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
  erb :'signin'
end

get '/voyages' do
  if current_user
    @voyages = Voyage.all
    @crew_member = current_user
    erb :'voyages/index'
  else
    redirect '/signin_signup'
  end
end

get '/voyages/:id/matches' do
  @voyage = Voyage.find(params[:id])
  @voyages = Voyage.where('start_port_id = ?', @voyage.start_port_id).where('start_date = ?', @voyage.start_date)
  @user = CrewMember.find(3)
  @crew_size = Voyage.find(params[:id]).crew_members.length
  @id = params[:id]
  erb :'/voyages/matches'
end

get '/voyages/:id/matches/friends' do
  @crew_members = Voyage.find(params[:id]).crew_members
  @ship_name = Voyage.find(params[:id]).ship.name
  erb :'/voyages/friends'
end

# get '/voyages/crew_voyage' do
#    @voyage = Voyage.crew_voyage
# end

get '/matches' do
  erb :'voyages/matches'
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
    # binding.pry
    session[:id] = @user.id
    redirect '/voyages'

  end
end

get '/logout' do
  session[:id] = nil
  redirect '/'
end

