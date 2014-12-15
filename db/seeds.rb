#LANGUAGES
Language.delete_all
bosanski = Language.create!(name: 'bosanski', short_name: 'ba')

# ADDRESSES
Address.delete_all

# ROLES
role = Role.find_or_initialize_by(name: 'administrator');
role.save!
role = Role.find_or_initialize_by(name: 'registered user');
role.save!


# USERS
User.delete_all
role = Role.find_by(name: 'administrator');
User.create!(name: 'amina',
             password: 'amina',
             role_id: "#{role.id}",
             email: 'amina@amina.com')

User.create!(name: 'ilma',
             password: 'admin',
             role_id: "#{role.id}",
             email: 'admin@admin.com')

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

# COUNTRIES
Country.delete_all
ba = Country.create!(name: "Bosna i Hercegovina")
hr = Country.create!(name: "Hrvatska")
sr = Country.create!(name: "Srbija")
br = Country.create!(name: "Brazil")

# CITIES
City.delete_all
City.create!(name: "Sarajevo", postal_code: "71000", country_id: "#{ba.id}")
City.create!(name: "Tuzla", postal_code: "73245", country_id: "#{ba.id}")
City.create!(name: "Banja Luka", postal_code: "73312", country_id: "#{ba.id}")
City.create!(name: "Bihac", postal_code: "75600", country_id: "#{ba.id}")
City.create!(name: "Zagreb", postal_code: "51000", country_id: "#{hr.id}")
City.create!(name: "Split", postal_code: "87540", country_id: "#{hr.id}")
City.create!(name: "Beograd", postal_code: "58770", country_id: "#{sr.id}")
City.create!(name: "Rio de Janeiro", postal_code: "75580", country_id: "#{br.id}")


#CATEGORIES
Category.delete_all
men_shoes = Category.find_or_initialize_by(name: "Men's Shoes")
men_shoes.save!

women_shoes = Category.find_or_initialize_by(name: "Women's Shoes")
women_shoes.save! 

accessorize = Category.create!(name: "Accessorize")
winter_shoes = Category.create!(name: "Winter 14/15")

#CATEGORY TRANSLATIONS
CategoryTranslation.create!(language_id: "#{bosanski.id}",
                            category_id: "#{women_shoes.id}",
                            name: "Zenska obuca")

CategoryTranslation.create!(language_id: "#{bosanski.id}",
                            category_id: "#{men_shoes.id}",
                            name: "Muska obuca")

CategoryTranslation.create!(language_id: "#{bosanski.id}",
                            category_id: "#{accessorize.id}",
                            name: "Dodaci")

CategoryTranslation.create!(language_id: "#{bosanski.id}",
                            category_id: "#{winter_shoes.id}",
                            name: "Zima 14/15")



# PRODUCTS
Product.delete_all

# PRODUCT IMAGES
ProductImage.delete_all

# PRODUCT VARIANTS
ProductVariant.delete_all

# PRODUCT TRANSLATIONS
ProductTranslation.delete_all




