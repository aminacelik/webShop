# ROLES
Role.delete_all
role = Role.find_or_initialize_by(name: 'Administrator');
role.save!
role = Role.find_or_initialize_by(name: 'registered user');
role.save!


# ADDRESS TYPES
AddressType.delete_all
at = AddressType.find_or_initialize_by(name: 'shipping');
at.save!
at = AddressType.find_or_initialize_by(name: 'billing');
at.save!

# LINE ITEMS
LineItem.delete_all



# CARTS
Cart.delete_all

# COLORS
Color.delete_all
black = Color.create!(name: 'black')
brown = Color.create!(name: 'brown')
red = Color.create!(name: 'red')
white = Color.create!(name: 'white')
pink = Color.create!(name: 'pink')
grey = Color.create!(name: 'grey')
blue = Color.create!(name: 'blue')

#SIZES
Size.delete_all
s36 = Size.create!(size: 36)
s37 = Size.create!(size: 37)
s38 = Size.create!(size: 38)
s39 = Size.create!(size: 39)
s40 = Size.create!(size: 40)
s41 = Size.create!(size: 41)
s42 = Size.create!(size: 42)
s43 = Size.create!(size: 43)


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
p = Product.create!(title: 'Christian Louboutin Fifi',
  				description: 'Fabulous "Fifi" is a single sole must-have for the Louboutin lady. Her round toe and slender heel provide a sophisticated silhouette that is perfect for a day in the office or an evening out on the town.',
  				image_url: 'fifi.jpg',    
  				price: 136.00,
				category_id: women_shoes_id )

ProductVariant.delete_all
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s36.id}", color_id: "#{white.id}", quantity: 3)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{white.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{white.id}", quantity: 8)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s39.id}", color_id: "#{white.id}", quantity: 5)


#2
p = Product.create!(title: 'Christian Louboutin Pigalle Follies Red',
  				description:'A new variation on a very classic theme, "Pigalle Follies" is our iconic "Pigalle" refitted with a superfine stiletto heel. The effect is a daring new "Pigalle" with a plunging 120mm pitch.',
				image_url: 'pigalle_follies.jpg',
				price: 170.95,
				category_id: women_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s36.id}", color_id: "#{red.id}", quantity: 3)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{red.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{red.id}", quantity: 8)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s39.id}", color_id: "#{red.id}", quantity: 5)


#3
p = Product.create!(title: 'Christian Louboutin Pigalle Follies Red Limited Edition',
  				description:'Limited Edition',
				image_url: 'shoes3.jpg',
				price: 149.95,
				category_id: women_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{red.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{red.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s39.id}", color_id: "#{red.id}", quantity: 2)


#4
p = Product.create!(title: 'Christian Louboutin Pigalle Follies Black',
  				description:'A new variation on a very classic theme, "Pigalle Follies" is our iconic "Pigalle" refitted with a superfine stiletto heel. The effect is a daring new "Pigalle" with a plunging 120mm pitch.',
				image_url: 'shoes4.jpg',
				price: 149.95,
				category_id: women_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{black.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{black.id}", quantity: 8)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s39.id}", color_id: "#{black.id}", quantity: 5)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s40.id}", color_id: "#{black.id}", quantity: 5)

#5
p = Product.create!(title: 'Christian Louboutin So Kate',
  				description: 'Her superfine heel makes "So Kate" one of the most delicate of all Louboutin pointed toe pumps. And in our newest "Tissu Beauty," "So Kate" is one sultry stiletto who\'s ready to turn heads.',
  				image_url: 'so_kate.jpg',
  				price: 134.95,
				category_id: women_shoes_id)


ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{black.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{black.id}", quantity: 6)

#6
p = Product.create!(title: 'Louis Junior Sp Crepe',
  				description: 'Satin/Satin/Lurex',
  				image_url: 'louis.jpg',
  				price: 204.95,
				category_id: women_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{pink.id}", quantity: 1)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{pink.id}", quantity: 1)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s39.id}", color_id: "#{pink.id}", quantity: 1)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s40.id}", color_id: "#{pink.id}", quantity: 1)


#7
p = Product.create!(title: 'Glitter Grey Shoes',
  				description: 'Limited Edition',
  				image_url: 'shoes2.jpg',
  				price: 70.00,
				category_id: women_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{grey.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{grey.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s39.id}", color_id: "#{grey.id}", quantity: 10)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s40.id}", color_id: "#{grey.id}", quantity: 2)

#8 
p = Product.create!(title: 'Electric Blue Shoes',
  				description: 'Very Expensive',
  				image_url: 'shoes1.jpg',
  				price: 84.95,
				category_id: women_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s37.id}", color_id: "#{blue.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s38.id}", color_id: "#{blue.id}", quantity: 10)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s39.id}", color_id: "#{blue.id}", quantity: 2)

# MEN SHOES

#1
p = Product.create!(title: 'Autumn Shoes',
  				description: 'Stylish',
  				image_url: 'men_shoes1.jpg',
  				price: 93.95,
				category_id: men_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s40.id}", color_id: "#{brown.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s41.id}", color_id: "#{brown.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s42.id}", color_id: "#{brown.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s43.id}", color_id: "#{brown.id}", quantity: 2)

#2
p = Product.create!(title: 'Just another regular shoes',
  				description: 'Super comfortable for outside activites, no matter what\'s the weather like. ',
  				image_url: 'men_shoes2.jpg',
  				price: 104.95,
				category_id: men_shoes_id)

ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s40.id}", color_id: "#{black.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s41.id}", color_id: "#{black.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s42.id}", color_id: "#{black.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s43.id}", color_id: "#{black.id}", quantity: 2)

#3
p = Product.create!(title: 'Winter Boots',
  				description: 'Material: leather',
  				image_url: 'men_shoes3.jpg',
  				price: 211.00,
				category_id: men_shoes_id)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s40.id}", color_id: "#{black.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s41.id}", color_id: "#{black.id}", quantity: 2)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s42.id}", color_id: "#{black.id}", quantity: 4)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s43.id}", color_id: "#{black.id}", quantity: 2)

#4
p = Product.create!(title: 'Dolce & Gabanna 2425',
  				description: 'The Must Have Shoes for Men for 2014.',
  				image_url: 'men_shoes4.jpg',
  				price: 344.55,
				category_id: men_shoes_id)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s40.id}", color_id: "#{black.id}", quantity: 1)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s41.id}", color_id: "#{black.id}", quantity: 1)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s42.id}", color_id: "#{black.id}", quantity: 1)
ProductVariant.create!(product_id: "#{p.id}", size_id: "#{s43.id}", color_id: "#{black.id}", quantity: 1)








