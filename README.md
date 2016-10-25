# sql-and-active-record
Tuesday homework

1.) How many users are there?
  [1] pry(main)> User.count
   (0.2ms)  SELECT COUNT(*) FROM "users"
    => 50

2.) What are the 5 most expensive items?
  [5] pry(main)> price = Item.order(price: :desc).limit(5)
  Item Load (0.8ms)  SELECT  "items".* FROM "items" ORDER BY "items"."price" DESC LIMIT ?  [["LIMIT", 5]]
=> [#<Item:0x007f9865bad1f0
  id: 25,
  title: "Small Cotton Gloves",
  category: "Automotive, Shoes & Beauty",
  description: "Multi-layered modular service-desk",
  price: 9984>,
 #<Item:0x007f9865bacd68
  id: 83,
  title: "Small Wooden Computer",
  category: "Health",
  description: "Re-engineered fault-tolerant adapter",
  price: 9859>,
 #<Item:0x007f9865bac958
  id: 100,
  title: "Awesome Granite Pants",
  category: "Toys & Books",
  description: "Upgradable 24/7 access",
  price: 9790>,
 #<Item:0x007f9865bac4a8
  id: 40,
  title: "Sleek Wooden Hat",
  category: "Music & Baby",
  description: "Quality-focused heuristic info-mediaries",
  price: 9390>,
 #<Item:0x007f9865bac0e8
  id: 60,
  title: "Ergonomic Steel Car",
  category: "Books & Outdoors",
  description: "Enterprise-wide secondary firmware",
  price: 9341>]

3.) What's the cheapest book?
  [15] pry(main)> Item.where(category: 'Books').order(price: :asc).limit(1)
  Item Load (0.3ms)  SELECT  "items".* FROM "items" WHERE "items"."category" = ? ORDER BY "items"."price" ASC LIMIT ?  [["category", "Books"], ["LIMIT", 1]]
=> [#<Item:0x007f98673476d0
  id: 76,
  title: "Ergonomic Granite Chair",
  category: "Books",
  description: "De-engineered bi-directional portal",
  price: 1496>]
  
4.) Who lives at "6439 Zetta Hills, Willmouth, WY"? Do they have another address?
  [9] pry(main)> Address.joins(:user).where('street'=> '6439 Zetta Hills')
  Address Load (0.2ms)  SELECT "addresses".* FROM "addresses" INNER JOIN "users" ON "users"."id" = "addresses"."user_id" WHERE "addresses"."street" = ?  [["street", "6439 Zetta Hills"]]
=> [#<Address:0x007ff4de913680
  id: 43,
  user_id: 40,
  street: "6439 Zetta Hills",
  city: "Willmouth",
  state: "WY",
  zip: 15029>]
  
    [10] pry(main)> Address.joins(:user).where('users.first_name' => 'Corrine')
  Address Load (0.3ms)  SELECT "addresses".* FROM "addresses" INNER JOIN "users" ON "users"."id" = "addresses"."user_id" WHERE "users"."first_name" = ?  [["first_name", "Corrine"]]
=> [#<Address:0x007ff4e4359c20
  id: 43,
  user_id: 40,
  street: "6439 Zetta Hills",
  city: "Willmouth",
  state: "WY",
  zip: 15029>,
 #<Address:0x007ff4e4359ab8
  id: 44,
  user_id: 40,
  street: "54369 Wolff Forges",
  city: "Lake Bryon",
  state: "CA",
  zip: 31587>]

5.) Correct Virginie Mitchell's address to "New York, NY, 10108".
  [18] pry(main)> user.addresses.update_all(city: 'New York', state: 'NY',zip:'10108')
  SQL (93.1ms)  UPDATE "addresses" SET "city" = 'New York', "state" = 'NY', "zip" = 10108 WHERE "addresses"."user_id" = ?  [["user_id", 39]]
=> 2
[19] pry(main)> user.addresses
=> [#<Address:0x007ff4e420ba08
  id: 41,
  user_id: 39,
  street: "12263 Jake Crossing",
  city: "Roxanehaven",
  state: "NY",
  zip: 34705>,
 #<Address:0x007ff4e420b8a0
  id: 42,
  user_id: 39,
  street: "83221 Mafalda Canyon",
  city: "Bahringerland",
  state: "WY",
  zip: 24028>]
[20] pry(main)> user.addresses.reload
  Address Load (0.2ms)  SELECT "addresses".* FROM "addresses" WHERE "addresses"."user_id" = ?  [["user_id", 39]]
=> [#<Address:0x007ff4dedfa018
  id: 41,
  user_id: 39,
  street: "12263 Jake Crossing",
  city: "New York",
  state: "NY",
  zip: 10108>,
 #<Address:0x007ff4dedf9ed8
  id: 42,
  user_id: 39,
  street: "83221 Mafalda Canyon",
  city: "New York",
  state: "NY",
  zip: 10108>]

6.) How much would it cost to buy one of each tool?
  [27] pry(main)> Item.where('category like ?', '%Tool%').sum :price
   (0.2ms)  SELECT SUM("items"."price") FROM "items" WHERE (category like '%Tool%')
  => 46477

7.) How many total items did we sell?
  [28] pry(main)> Order.sum(:quantity)
   (0.3ms)  SELECT SUM("orders"."quantity") FROM "orders"
  => 2125

8.) How much was spent on books?
  [34] pry(main)> Item.select("sum(price * quantity) as value").from("items, orders").where("category = 'Books'and orders.item_id = items.id").first.value
  Item Load (0.5ms)  SELECT  sum(price * quantity) as value FROM items, orders WHERE (category = 'Books'and orders.item_id = items.id) ORDER BY "items"."id" ASC LIMIT ?  [["LIMIT", 1]]
  => 420566

9.) Simulate buying an item by inserting a User for yourself and an Order for that User.
  
