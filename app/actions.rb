# Homepage (Root path)
get '/' do
  erb :index
end

get '/voyages' do
  erb :voyages
end
