require 'faker'
require 'HTTParty'

GenreMovie.destroy_all
List.destroy_all
Genre.destroy_all
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

def get_data(call_url)
    request = HTTParty.get(call_url).to_json
    return JSON.parse(request)
end

#gets a list of movies
discover_URL = "https://api.themoviedb.org/3/discover/movie?"
api_key = ENV['API_KEY']
other_params = "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=true&page=1"
call_url = discover_URL+api_key+other_params
request_hash = get_data(call_url) 

f = File.new('results.json', 'w') #NOT NEEDED; PUTS THE RESULT IN A FILE
f << request_hash.to_json
f.close

#get the ids of all the movies so we can get the detail of each movie by api call
movies_id = request_hash["results"].map{ |movie| movie["id"] }
movie_url = "https://api.themoviedb.org/3/movie/"
additional_params = "&language=en-US&append_to_response=videos,images"

#map through the movie_ids and call for the detail of each movie
movies_id.map{ |id|
    movie_id = "#{id}?"
    call_url = movie_url+movie_id+api_key+additional_params
    movie_hash = get_data(call_url)
    title = movie_hash["title"]
    overview = movie_hash["overview"]
    release_date = movie_hash["release_date"]
    runtime = "#{movie_hash["runtime"]} mins"
    #TODO: there's more than one src, create a table and get them all later; also many images...
    src = "https://www.youtube.com/watch?v=#{movie_hash["videos"]["results"][0]["key"]}" if movie_hash["videos"]["results"][0]["site"] == "YouTube"
    image_src = "https://image.tmdb.org/t/p/original#{movie_hash["backdrop_path"]}"
    movie = {title: title, overview: overview, release_date: release_date, runtime: runtime, src: src, image_src: image_src}
    this_movie = Movie.create(movie)

    #create the genre and associate it with a movie
    movie_hash["genres"].map {
        |genre|
        this_genre = Genre.find_or_create_by(name: genre["name"])
        this_movie.genres.push(this_genre)
    }
}

