# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Message.destroy_all
# Booking.destroy_all
# Offer.destroy_all
# Book.destroy_all

books = [

  {
    title: 'Les fondamentaux de la typographie',
    description: 'Cette version revue et remaquettée des fondamentaux de la typographie explore les principes théoriques de la typographie et leurs multiples applications. Il passe en revue les différents paramètres d une composition typographique et se penche sur l utilisation créative des caractères, tant sur les supports imprimés qu à l écran. Les principes fondamentaux de la typographie sont expliqués pas à pas et accompagnés d exemples de compositions anciennes ou contemporaines.',
    category: 'Typographie',
    author: 'Gavin Ambrose',
    image: 'http://ecx.images-amazon.com/images/I/41v5YywoYyL._SX439_BO1,204,203,200_.jpg'
  },

  {
    title: 'Les fondamentaux du graphisme',
    description: "Graphisme offre une vue d'ensemble unique sur les multiples facettes de l'industrie du graphisme et ses procédés. Divisé en six chapitres, l'ouvrage aborde le graphisme en tant que discipline et se penche sur ses influences et éléments de création, sur les processus graphique et de production, ainsi que sur la meilleure manière de transmettre des messages efficaces et de s'autopromouvoir.",
    category: 'Graphisme',
    author: 'Paul Harris',
    image: 'http://ecx.images-amazon.com/images/I/51Tb-MJIsGL._SX426_BO1,204,203,200_.jpg'

  },

  {
    title: 'Concevez votre site web avec PHP et MySQL',
    description: "Blogs, réseaux sociaux, pages d'accueil personnalisables... Depuis quelques années, les sites web ont gagné en fonctionnalités et sont devenus dans le même temps de plus en plus complexes. Que le temps de la 'page web perso' est loin ! Aujourd'hui, il faut que ça bouge !",
    category: 'Developpement',
    author: 'Mathieu Nebra',
    image: 'http://ecx.images-amazon.com/images/I/41Q5qRj-f1L._SX346_BO1,204,203,200_.jpg'

  },

  {
    title: 'Design émotionnel',
    description: 'Engagez émotionnellement les visiteurs de votre site Web en leur offrant une expérience positive grâce aux préceptes énoncés dans ce petit et brillant ouvrage écrit par le designer spécialiste en expérience utilisateur, Aarron Walter.',
    category: 'UX',
    author: 'Aarron Walter',
    image: 'http://ecx.images-amazon.com/images/I/41kftZ9jqCL._SX328_BO1,204,203,200_.jpg'

  },

  {
    title: 'Mobile First',
    description: "Le designer de renom, ancien architecte du design de Yahoo!, Luke Wroblewski, nous fait partager dans ce petit guide stratégique toutes ses connaissances et son savoir-faire en matière d'expérience mobile.",
    category: 'Webdesign',
    author: 'Luke Wroblewski',
    image: 'http://ecx.images-amazon.com/images/I/31fxBpqHnRL._SX322_BO1,204,203,200_.jpg'

  }
]

books.each {|book| Book.create(book)}
