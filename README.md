## Instalation

# Django

create a virtual env and run requirements.txt to install package

# Flutter setup 

download flutter setup on this link and follow instructions
https://docs.flutter.dev/

## Endpoints
Creating clerk or admin

You can use either local host or live link

https://wisem.pythonanywhere.com/api/signup/ [POST]

request body for admin

{

    "username": "john_doe2",
    "password": "securepassword123",
    "email": "john.doe@example.com",
    "role": "admin"
}

for clerk

{

    "username": "john_doe2",
    "password": "securepassword123",
    "email": "john.doe@example.com",
    "role": "clerk"
}

# login

https://wisem.pythonanywhere.com/api/login_user/ [POST]

{
  "username": "john_doe",
    "password": "securepassword123"
}

# other endpoints, you can replace the localhost with live link

http://localhost:8000/api/farmer-data/ [POST, GET]

{
  "farmer_name": "string",
  "nation_id": "string",
  "farm_type": 20,
  "crop_type":8,
  "crop": "string",
  "location": "string"
}


https://wisem.pythonanywhere.com/api/farm-types/ [POST, GET]

{
    "farm_type": "Tobbacco"
}


http://localhost:8000/api/combined_save/ [POST]

{
    "farm_data": {
         "farm_type": "Tobbacco"
    },
    "crop_type": {
        "crop_type":"jsjsjsjsjs"
    }
}

http://localhost:8000/api/croptype-options/ [POST, GET]

## USE THOSE CREDENTIALS TO LOGIN THE FLUTTER APP