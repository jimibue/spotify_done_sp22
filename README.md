# Spotify
we are going to create a very simplified spotify. In this app we will be able to create artists and songs. However there is a relationship between songs and artist.  A artist can have many songs, but a song can ONLY HAVE 1 artist.  This might not be true in the real world but this is how our app is going to be setup.

```
artist {id:PK, name: string, num_fans:integer}
songs {id:PK, name:string, listens:play_count, artist_id:FK}

PK: Primary key: a unique integer to each entry in the table
FK: Foreign key: a primary key of a entry from another table, the way we can relate 
what is the thing this entry belongs to.
```

demo data
```ruby
#Artists
mj = {id:1 name:'Micheal Jackson', fans:1000011}
britney = {id:2 name:'Britney Spears', fans:10000}

#Songs
{id:1 name:'Opps I done it agains', listens:123123,artist_id:2 }
{id:2 name:'Hit me baby one more time', listens:123123,artist_id:2 }
{id:3 name:'thriller', play_count:123123, artist_id:1 }
{id:4 name:'smooth criminal', play_count:123123,artist_id:1 }
```

here we can relate which songs belongs to each artist by keeping track of the artist_id for each song.

# Setup
```
$ rails new spotify -d postgresql --api
$ cd spotify
$ git add .
$ git commit -m 'init'
$ rails db:create
```

# Part 1 Artist setup
This is what we have done so not much new here
```
$ rails g model artist name:string fans:integer
$ rails db:migrate
$ rails g controller api/artists
```

## seeding our db
we can add code to 'seed' or pre-populate or database with data

seeds.rb (not required, but nice to have)
```
britney = Artist.create(name:'Britney',fans:124234)
mj = Artist.create(name:'Michael Jackson',fans:1224234)
```

```
$ rails db:seed
// see our data
$ rails c
> Artist.all
....
// to exit rails c type 'exit'
> exit
```

routes.rb
```ruby
  namespace :api do
    get 'artists', to:'artists#index'
    get 'artists/:id', to:'artists#show'
    post 'artists', to:'artists#create'
    put 'artists/:id', to:'artists#update'
    delete 'artists/:id', to:'artists#destroy'
  end
```

artists_controller.rb
```ruby
class Api::ArtistsController < ApplicationController
    # set @artist in our show, update, destroy methods
    before_action :set_artist, only: [:show, :update, :destroy]
   
    def index
        render json: Artist.all
    end

    def show
        render json: @artist
    end
   
    def create
        @artist = Artist.new(artists_params)
        if(@artist.save)
            render json: @artist
        else
            render json: {errors: @artist.errors.full_messages}, status: 422
        end
    end
   
    def update
        if(@artist.update(artists_params))
            render json: @artist
        else
            render json: {errors: @artist.errors.full_messages}, status: 422
        end
    end
   
    def destroy
        render json: @artist.destroy
    end

    private
    
    def artists_params
      params.require(:artist).permit(:name, :fans)
    end

    # this method will be called before  show, update, destroy methods
    def set_artist
      @artist = Artist.find(params[:id])
    end
end
```

# Inception Time...  has many / belongs to

```
$ rails g model song name:string play_count:integer artist:belongs_to
$ rails db:migrate
$ rails g controller api/songs
```  
## create the Association in the models

```ruby
# song.rb
class Song < ApplicationRecord
  belongs_to :artist
end

# artist.rb
class Artist < ApplicationRecord
  # dependent: :destroy say when you destroy an artist go ahead and also
  # destroy all the songs that belong to an artist
    has_many :songs, dependent: :destroy
end

```

seeds.rb
```ruby
britney = Artist.create(name:'Britney',fans:124234)
mj = Artist.create(name:'Michael Jackson',fans:1224234)


# with artist 'Instance' methods 
britney.songs.create(name:'Hit me baby one more time', play_count:1324)
britney.songs.create(name:'opps gone dun it again', play_count:1324324)
mj.songs.create(name:'thriller', play_count:324324)
mj.songs.create(name:'smooth criminal', play_count:3124324)

# with Song class method (need artist_id)
Song.create(name:'Annie you ok', play_count:3124324, artist_id:mj.id)
Song.create(name:'Toxxiz', play_count:3124324, artist_id:britney.id)

# wont work no artist_id given
# Song.create(name:'change the world', play_count:3124324,) 
```

```
$ rails db:reset
$ rails db:seed
// lets explore our data
$ rails c
> Artist.all
> Song.all
> Artist.first
> Artist.first.songs
> Song.last.artist
``` 

routes.rb
```ruby
  namespace :api do
    get 'artists', to:'artists#index'
    get 'artists/:id', to:'artists#show'
    post 'artists', to:'artists#create'
    put 'artists/:id', to:'artists#update'
    delete 'artists/:id', to:'artists#destroy'

    get 'artists/:artist_id/songs', to:'songs#index'
    get 'artists/:artist_id/songs/:id', to:'songs#show'
    post 'artists/:artist_id/songs', to:'songs#create'
    put 'artists/:artist_id/songs/:id', to:'songs#update'
    delete 'artists/:artist_id/songs/:id', to:'songs#destroy'
  end
```

songs_controller.rb
```ruby
class Api::SongsController < ApplicationController
    before_action :set_artist
    before_action :set_song, only: [:show, :update, :destroy]
   
    def index
        render json: @artist.songs.all
    end

    def show
        render json: @song
    end
   
    def create
        @song = @artist.songs.new(songs_params)
        if(@song.save)
            render json: @song
        else
            render json: {errors: @song.errors.full_messages}, status: 422
        end
    end
   
    def update
        if(@song.update(songs_params))
            render json: @song
        else
            render json: {errors: @song.errors.full_messages}, status: 422
        end
    end
   
    def destroy
        render json: @song.destroy
    end

    private
    
    def songs_params
      params.require(:song).permit(:name, :play_count)
    end

    # this method will be called before  all methods
    def set_artist
      @artist = Artist.find(params[:artist_id])
    end


    # this method will be called before  show, update, destroy methods
    def set_song
        @song = @artist.songs.find(params[:id])
    end
end
```

