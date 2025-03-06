# cart_system

## Cart System is a flutter app that shows some products for the user, The user can add these products to his cart.

- Cart system built with clean architecture, It's divided into 4 layers:
- 
1- `App layer:` it's contains the Di for the whole modules, extensions that handle nullable values, and the failure class 
to handle the expected exceptions "In our case we use local storage".

2- `Data layer:` In the data layer, we have the data source that helps us to get data "From assets in our case", these data are product data, and then we do operations
on these data, Users can add or delete products to their carts, this layer contains 3 services 1'st product data source is to get all products from assets to show them to users.
2'nd is the cart data source that stores the chosen products from users with their quantities "In our case we use hive" so users can get or add or delete their chosen products.
3'rd is the promo code data source here we get the promo code from the data source "From Assets in our case" so when the user enters his promo code, we can compare it to our promo codes
then give him a discount depending on his promo code. The data layer also contains the mappers that allow for converting the responses to entities in the domain layer and vice versa, these mappers
help us to separate the data layer from the domain layer, and finally, it contains the repository implementation that gets or sends the data to the data source then send them to the domain layer through the mappers so the separation between data and domain layers is granted.

3- `Domain layer:` it contains the abstractions and business logic, so it has no idea about where we get the data from, and the use cases contain the business logic for the data "get, add, delete ..."
every use case is separated from the other one, for the cart we have more than usecase so i separated them to achieve the single responsibility principle but in the same dart file.

4- `Presentation layer:` here's the UI where users interact, it contains the pages or screens design of the app, in our case we have 2 screens one for showing products in grid view and the other for showing the cart "chosen products" in list view and the items count and the total price in a clickable container shows bottom sheet for checkout it contains a text field for promo code for the users that have promo codes
and a container that contains the details of the chosen items count and total price and price after discount if the user has a promo code, Users can add or delete items through both product screen or cart screen and showing the chosen products with the quantity for each one. the presentation layer also contains the shared widgets that are used in both screens, shared cubits, utils, and the resource for Strings, Assets, font styling, and the app theme.

## Promo codes: 

You can use these promo codes for testing: [DISCOUNT10, SALE20, WELCOME5, BLACKFRIDAY]

## Technologies

- Clean architecture: For readable, flexible, and scalable code.
  
- bloc (cubit): For state management: Simple, effective for state management, and perfect for clean architecture.
  
- Hive: For offline storage to store cart data and do operations on it, it supports custom objects, simple, rapid, and good for performance.
  
- get_it package: For dependency injection to avoid boilerplate and memory leaks by avoiding using new instances.
  
- dartz package: For exceptions handling in a readable way.
  
- json_serializable: For auto-generated files that help us to convert objects to or from JSON.
  
- screen utils package and MediaQuery: For responsive app.

## Installation

- You can install the app through downloading the ZIP file from GitHub or using the Android Studio or VS terminal 
and executing these orders:

`https://github.com/Ahmed113/cart_system.git`

`cd project-folder`

`flutter pub get`

`flutter run`
