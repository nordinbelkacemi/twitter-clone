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

user = User.create!(
    email: "123@gmail.com",
    password: "123123"
)

Post.create!(
    user: user,
    content: "I'm hungry"
)

Post.create!(
    user: user,
    content: "Browsing? Please use the search box at the top of this page or the links to the right. Feel free to subscribe to our syndicated feeds."
)

Post.create!(
    user: user,
    content: "Using? To fulfill the free license requirements, please read our Reuse guide. You can also request a picture."
)

Post.create!(
    user: user,
    content: "Identifying? Have a browse through Category:Unidentified subjects. If you find something you can identify, write a note on the item's talk page."
)

Post.create!(
    user: user,
    content: "Creating? Check out all you need to know at our Contributing your own work guide."
)

Post.create!(
    user: user,
    content: "and more! To explore more ways you can contribute to this project, check out the Community Portal."
)

Comment.create!(
    user: user,
    post: Post.first,
    content: ":("
)

Like.create!(
    user: User.first,
    likeable: Post.first 
)

Like.create!(
    user: User.first,
    likeable: Comment.first 
)