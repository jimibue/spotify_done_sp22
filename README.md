# Spotify
we are going to create a very simplified spotify. In this app we will be able to create artists and songs. However there is a relationship between songs and artist.  A artist can have many songs, but a song can ONLY HAVE 1 artist.  This might not be true in the real world but this is how our app is going to be setup.

```
artist {id:PK, name: string, num_fans:integer}
songs {id:PK, name:string, listens:count, artist_id:FK}

PK: Primary key: a unique integer to each entry in the table
FK: Foreign key: a primary key of a entry from another table, the way we can realate 
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
{id:3 name:'thriller', listens:123123, artist_id:1 }
{id:4 name:'smooth criminal', listens:123123,artist_id:1 }
```

here we can relate which songs belongs to each artist by keeping track of the artist_id for each song.

# Setup
```
$ rails new spotify -d postgresql --api
$ cd spotify
```

