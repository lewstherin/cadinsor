Cadinsor
===
##What is Cadinsor?
Cadinsor provides OAuth like authentication to validate requests from your client apps to your backend Rails application. It can be easily mounted onto any application as it is a Rails engine.

## Setup Instructions
###To be added


## So how does it work?
Every request that is authenticated through Cadinsor must possess among it's parameters:

  1. A valid server issued key

  2. A valid app id

  3. A proper request signature

### Key Components
  * **An APP ID/ Secret**: Each client application has a unique APP ID and an "APP Secret" string. The app id is sent as part of every request from the client app. The app secret is not sent with the request, and is instead used to build the request signature (explained below).
  * **A Server Issued Key/ Key Fetch API**: In order to keep each request from the app independent, a server issued unique key string is sent along with request. A key is obtained by making a call the Key Fetch API. It is a public API and requires no parameters except an optional app id. The key has a time bound expiry (default = 5mins, specified in the config file) and is invalidated after each request to the backend application.

### Building the request signature at the client side
All the request parameters are sortd in alphabetical order and a request string is obtained by concatenating the corresponding values of these paremeters. To this string, the app secret and an SHA2 (256 bit) hash is computed of this string. This signature is also sent with every request to the server.
Ex: Consider a simple login request with the following parameters:

  1. User Name: lewstherin
  2. Password: thedragon
  3. Key: N1ilN8qZmOXodohO-9IRvpxZmVDY_Zg8P7r9JoDpFs4
  4. App Id: 2

In alphabetical order, these parameters become App Id, Key, Password and User name. Assuming the app secret is "CaraianCaldazar!", our request string becomes "2N1ilN8qZmOXodohO-9IRvpxZmVDY_Zg8P7r9JoDpFs4thedragonlewstherinCaraianCaldazar!". Now the SHA2 hash of this string is "ab71fc84351c4cdfd23c31ea2ce4133b38cd3c21cfee48d3d15501e726c16734" and this is sent along with the request as the parameter signature.
At the server end, Cadinsor will rebuild this signature and check if it matches with the input signature. If it does, it means the client has sent a valid app secret and thus the request is from a trusted source.

### Validating your requests at the controller side
#### To Do

## Action Items

  1. Add tests
  2. Figure out an easy way to add new apps
  3. Make key checking optional
  4. Move cadinsor to a gem
  5. Improve this documentation with detailed setup and controller side instructions.

## License
[MIT License](http://opensource.org/licenses/MIT)