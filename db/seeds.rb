# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(profile_pic: 'https://ih0.redbubble.net/image.425051630.0008/flat,750x,075,f-pad,750x1000,f8f8f8.u3.jpg', username: 'testuser', password: 'testpass')
User.create(profile_pic: 'http://images2.fanpop.com/image/photos/12200000/Surf-s-up-surfs-up-12226942-392-262.jpg', username: 'testuser2', password: 'testpass2')
Post.create(image: 'https://i6.lisimg.com/11890696/411full.jpg', caption: 'tank evans sucks', user_id: 1)
Comment.create(user_id: 2, post_id: 1, comment: 'boo tank')
