require 'faker'
require 'HTTParty'

Movie.destroy_all
Show.destroy_all
User.destroy_all

3.times do 
    name = Faker::Name.name
    username = Faker::Internet.username
    email = Faker::Internet.email
    person = {name: name, username: username, email: email}
    User.create(person)
end

3.times do
    title = Faker::Movie.title
    overview = Faker::Movie.quote
    release_date = Faker::Date.forward(days: 23)
    runtime = Faker::Alphanumeric.alpha(number: 10)
    # genres = [Faker::Music.genre, Faker::Music.genre]
    movie = {title: title, overview: overview, release_date: release_date, runtime: runtime}
    Movie.create(movie)
end

BASE_URL = "https://api.themoviedb.org/3/discover/movie?"
API_KEY = ENV['API_KEY']
other_params = "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"
call_url = BASE_URL+API_KEY+other_params
request = HTTParty.get(call_url).to_json
@request_hash = JSON.parse(request)

f = File.new('results.json', 'w')
f << @request_hash.to_json
f.close
