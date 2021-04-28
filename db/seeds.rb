# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.destroy_all
Comment.destroy_all
Post.destroy_all
User.destroy_all

user1 = User.create!(
    email: "123@gmail.com",
    password: "123123"
)

user2 = User.create!(
    email: Faker::Internet.email,
    password: "123123"
)

user3 = User.create!(
    email: Faker::Internet.email,
    password: "123123"
)

user4 = User.create!(
    email: Faker::Internet.email,
    password: "123123"
)

users = [user1, user2, user3, user4]

10.times do
    post = Post.new(
        user: users.sample,
        content: Faker::GreekPhilosophers.quote
    )
    post.save
end

# comments are all from ops
25.times do
    comment = Comment.new(
        user: users.sample,
        post: Post.all.sample,
        content: Faker::GreekPhilosophers.quote
    )
    comment.save
end

15.times do
    like = Like.new(
        user: users.sample,
        likeable: [Comment.all.sample, Post.all.sample].sample
    )
    like.save
end