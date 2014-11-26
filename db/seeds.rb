#LANGUAGES
#Language.delete_all
bosanski = Language.create!(name: 'bosanski', short_name: 'ba')

# ADDRESSES
Address.delete_all

# ROLES
role = Role.find_or_initialize_by(name: 'administrator');
role.save!
role = Role.find_or_initialize_by(name: 'registered user');
role.save!


# USERS
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
ba = Country.create!(name: "Bosna i Hercegovina")
hr = Country.create!(name: "Hrvatska")
sr = Country.create!(name: "Srbija")
br = Country.create!(name: "Brazil")

# CITIES
City.create!(name: "Sarajevo", postal_code: "71000", country_id: "#{ba.id}")
City.create!(name: "Tuzla", postal_code: "73245", country_id: "#{ba.id}")
City.create!(name: "Banja Luka", postal_code: "73312", country_id: "#{ba.id}")
City.create!(name: "Bihac", postal_code: "75600", country_id: "#{ba.id}")
City.create!(name: "Zagreb", postal_code: "51000", country_id: "#{hr.id}")
City.create!(name: "Split", postal_code: "87540", country_id: "#{hr.id}")
City.create!(name: "Beograd", postal_code: "58770", country_id: "#{sr.id}")
City.create!(name: "Rio de Janeiro", postal_code: "75580", country_id: "#{br.id}")


#CATEGORIES
men_shoes = Category.find_or_initialize_by(name: 'Men Shoes')
men_shoes.save!

women_shoes = Category.find_or_initialize_by(name: 'Women Shoes')
women_shoes.save! 

men_shoes_id = men_shoes.id
women_shoes_id = women_shoes.id

Category.create!(name: "Accessorize")
Category.create!(name: "Winter 14/15")

#CATEGORY TRANSLATIONS
CategoryTranslation.create!(language_id: "#{bosanski.id}",
                            category_id: "#{women_shoes.id}",
                            name: "Ženska obuća")

CategoryTranslation.create!(language_id: "#{bosanski.id}",
                            category_id: "#{men_shoes.id}",
                            name: "Muška obuća")


# FIND CATEGORIES
#men = Category.where(name: 'Muska obuca')
#women = Category.where(name: 'Zenska obuca')

# PRODUCTS
Product.delete_all





