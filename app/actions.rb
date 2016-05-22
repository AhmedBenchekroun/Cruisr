#get '/friends' do
#  erb :'voyages/friends'
#end



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

get '/profile' do
  @user = current_user
  erb :profile
end

#VOYAGES VIEW
get '/voyages' do
  if current_user
    @voyages = Voyage.all
    @crew_member = current_user
    erb :'voyages/index'
  else
    redirect '/signin_signup'
  end
end

#MATCHES VIEW
get '/voyages/:id/matches' do
  @voyage = Voyage.find(params[:id])
  @port = @voyage.start_port.city
  @date = @voyage.start_date
  @voyages = Voyage.where('start_port_id = ?', @voyage.start_port_id).where('start_date = ?', @voyage.start_date)
  @user = current_user
  @id = params[:id]
  erb :'/voyages/matches'
end

#FRIENDS VIEW
get '/voyages/:id/matches/:v_id/friends/' do
  @crew_members = Voyage.find(params[:v_id]).crew_members
  @ship_name = Voyage.find(params[:v_id]).ship.name
  @friends_list = current_user.list_of_friends(@crew_members)
  erb :'/voyages/friends'
end

#CREW VIEW
get '/voyages/:id/matches/:v_id/crew/' do
  @crew_members = Voyage.find(params[:v_id]).crew_members
  #@crew_members.delete(current_user)
  @city = Voyage.find(params[:id]).start_port.city
  @date = Voyage.find(params[:id]).start_date
  @user = current_user
  @ship_name = Voyage.find(params[:v_id]).ship.name
  erb :'/voyages/crew-members'
end


#get '/:id/matches' do
#  erb :'voyages/matches'
#end

#LOGIN
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

#SIGN UP
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
    session[:id] = @user.id
    redirect '/voyages'

  end
end

#LOGOUT
get '/logout' do
  session[:id] = nil
  redirect '/'
end

