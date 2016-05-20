# Homepage (Root path)
helpers do
  def current_user
    session[:id] ? @current_user = CrewMember.find(session[:id]) : nil
  end
end

get '/' do
  erb :index
end

get '/voyages' do
  @voyages = Voyage.all
  @crew_member = CrewMember.find(1)
  erb :'/voyages/voyages'
end

get '/voyages/:id/matches' do
  @voyage = Voyage.find(params[:id])
  @ship_name = Voyage.find(params[:id]).ship.name
  @voyages = Voyage.where('start_port_id = ?', @voyage.start_port_id).where('start_date = ?', @voyage.start_date)
  @user = CrewMember.find(1)
  @crew_size = Voyage.find(params[:id]).crew_members.length
  @id = params[:id]
  erb :'/voyages/matches'
end

get '/voyages/:id/matches/ship_friends' do
  @crew_members = Voyage.find(params[:id]).crew_members
  @ship_name = Voyage.find(params[:id]).ship.name
  @crew_size = Voyage.find(params[:id]).crew_members.length
  erb :'/voyages/ship_friends'
end


# get '/voyages/crew_voyage' do
#    @voyage = Voyage.crew_voyage
# end

# get '/dates' do
#   @voyage = Port.find params[:start_port_id]
#   erb :'voyages/show'
# end

# get '/voyages/new' do
#   @voyage = Voyage.new
#   erb :'voyages/new'
# end

# get '/voyages/search' do
#   @voyage = Voyage.find params[:id]
#   erb :'voyages/show'
# end

# get '/voyages' do
#   @voyage = Voyage.where()
# end

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
    @user = CrewMember.create(email: params[:email],
    full_name: params[:full_name],
    nationality: params[:nationality],
    date_of_birth: params[:date_of_birth],
    password: params[:password], password_confirmation: params[:password_confirmation])
    redirect '/voyages'

  end
end

post '/logout' do
  session.clear
  redirect '/'
end

