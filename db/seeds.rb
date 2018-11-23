user1 = User.new(email: 'sample1@example.com', password: 'password')
user1.save

user2 = User.new(email: 'sample2@example.com', password: 'password')
user2.save

Post.find_or_create_by(content: 'hoge', user_id: user1.id)
Post.find_or_create_by(content: 'hoge2', user_id: user1.id)
Post.find_or_create_by(content: 'hoge3', user_id: user2.id)
