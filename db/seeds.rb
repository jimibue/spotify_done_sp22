# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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