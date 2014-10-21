
# COLORS
Color.delete_all
Color.create!(name: 'black')
Color.create!(name: 'brown')
Color.create!(name: 'red')
Color.create!(name: 'white')
Color.create!(name: 'pink')
Color.create!(name: 'grey')


men_shoes = Category.find_or_initialize_by(name: 'Men Shoes')
men_shoes.save!

women_shoes = Category.find_or_initialize_by(name: 'Women Shoes')
women_shoes.save! 

men_shoes_id = men_shoes.id
women_shoes_id = women_shoes.id

# FIND CATEGORIES
#men = Category.where(name: 'Muska obuca')
#women = Category.where(name: 'Zenska obuca')

# PRODUCTS
Product.delete_all

#1
Product.create!(title: 'Christian Louboutin Fifi',
  				description: 'Fabulous "Fifi" is a single sole must-have for the Louboutin lady. Her round toe and slender heel provide a sophisticated silhouette that is perfect for a day in the office or an evening out on the town.',
  				image_url: 'fifi.jpg',    
  				price: 136.00,
				category_id: women_shoes_id )
#2
Product.create!(title: 'Christian Louboutin Pigalle Follies Red',
  				description:'A new variation on a very classic theme, "Pigalle Follies" is our iconic "Pigalle" refitted with a superfine stiletto heel. The effect is a daring new "Pigalle" with a plunging 120mm pitch.',
				image_url: 'pigalle_follies.jpg',
				price: 149.95,
				category_id: women_shoes_id)
#3
Product.create!(title: 'Christian Louboutin Pigalle Follies Red Limited Edition',
  				description:'Limited Edition',
				image_url: 'shoes3.jpg',
				price: 149.95,
				category_id: women_shoes_id)
#4
Product.create!(title: 'Christian Louboutin Pigalle Follies Black',
  				description:'A new variation on a very classic theme, "Pigalle Follies" is our iconic "Pigalle" refitted with a superfine stiletto heel. The effect is a daring new "Pigalle" with a plunging 120mm pitch.',
				image_url: 'shoes4.jpg',
				price: 149.95,
				category_id: women_shoes_id)
#5
Product.create!(title: 'Christian Louboutin So Kate',
  				description: 'Her superfine heel makes "So Kate" one of the most delicate of all Louboutin pointed toe pumps. And in our newest "Tissu Beauty," "So Kate" is one sultry stiletto who\'s ready to turn heads.',
  				image_url: 'so_kate.jpg',
  				price: 134.95,
				category_id: women_shoes_id)
#6
Product.create!(title: 'Louis Junior Sp Crepe',
  				description: 'Satin/Satin/Lurex',
  				image_url: 'louis.jpg',
  				price: 204.95,
				category_id: women_shoes_id)
#7
Product.create!(title: 'Glitter Grey Shoes',
  				description: 'Limited Edition',
  				image_url: 'shoes2.jpg',
  				price: 120.00,
				category_id: women_shoes_id)

#8 
Product.create!(title: 'Glitter Bridal Shoes',
  				description: 'Very Expensive',
  				image_url: 'shoes1.jpg',
  				price: 404.95,
				category_id: women_shoes_id)


# MEN SHOES

#1
Product.create!(title: 'Autumn Shoes',
  				description: 'Stylish',
  				image_url: 'men_shoes1.jpg',
  				price: 93.95,
				category_id: men_shoes_id)
#2
Product.create!(title: 'Just another regular shoes',
  				description: 'Super comfortable for outside activites, no matter what\'s the weather like. ',
  				image_url: 'men_shoes2.jpg',
  				price: 104.95,
				category_id: men_shoes_id)
#3
Product.create!(title: 'Winter Boots',
  				description: 'Material: leather',
  				image_url: 'men_shoes3.jpg',
  				price: 211.00,
				category_id: men_shoes_id)
#4
Product.create!(title: 'Dolce & Gabanna 2425',
  				description: 'The Must Have Shoes for Men for 2014.',
  				image_url: 'men_shoes4.jpg',
  				price: 344.55,
				category_id: men_shoes_id)





#SIZES
Size.delete_all
Size.create!(size: 36)
Size.create!(size: 37)
Size.create!(size: 38)
Size.create!(size: 39)
Size.create!(size: 40)
Size.create!(size: 41)
Size.create!(size: 42)
Size.create!(size: 43)


