# Sweater Weather
Sweater Weather is part of an SOA web-application. Its purpose is for determining a forecast based on your location or where you plan on traveling next. This application exposes four integral endpoints for the front end to consume.
1. Forecast for a location
2. Background image at that location
3. User creation
4. Planning a road trip



## Technologies
![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

## Database Schema:
![Screen Shot 2022-04-24 at 3 51 52 PM](https://user-images.githubusercontent.com/83717116/164998199-d6667249-adc0-48c3-935e-3c09f23ca6e7.png)

## APIs Used
  - [OpenWeather API](https://openweathermap.org/api)
  - [MapQuest](http://www.mapquestapi.com)
  - [Pexels](https://api.pexels.com)
## Endpoints: Requests & Responses

## Local Setup

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:create`
4. Run migrations: ` rails db:migrate`
6. Create an account with [OpenWeather API](https://home.openweathermap.org/users/sign_up) and request an API key
7. Create an account with [Pexels](https://www.pexels.com/api/) and request an API key
8. Create an account with [Mapquest API](https://developer.mapquest.com/documentation/open/directions-api/)
9. Install the Figaro gem: `bundle exec figaro install`
10. Add your API key to the `application.yml` created by Figaro:
  ```yml
  weather_api_key: your_api_key
  map_api_key: your_api_key
  photo_api_key: your_api_key
  ```
## INTERVIEWER
* After adding api keys to your application.yml file listed below

* start server
```
$ rails s
```
* Use below postman collection to get endpoints

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/b8ff93e51a5d15f17c03?action=collection%2Fimport)

## Endpoint Information:

### New User Endpoint
-  `POST '/api/v1/users'`
<details>
  <summary> Request body json </summary>

```json
{
    "email": "example_user@mail.com",
    "password": "12345",
    "password_confirmation": "12345"
}
```

</details>
<details>
  <summary> Successful response will look like:</summary>

```json
{
    "data": {
        "type": "users",
        "id": 3,
        "attributes": {
            "email": "example_user@mail.com",
            "api_key": "1P5Wp3Tq52jWpAAbAWnzcq5h"
        }
    }
}
```

</details>

### Road Trip Endpoint
-  `POST '/api/v1/road_trip'`
<details>
  <summary> Request body json **API KEY REQUIRED** </summary>

```json
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "1P5Wp3Tq52jWpAAbAWnzcq5h"
}
```

</details>
<details>
  <summary> Successful response will look like:</summary>

```json
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "01:45:23",
            "weather_at_eta": {
                "temperature": 57.6,
                "conditions": "broken clouds"
            }
        }
    }
}
```

</details>

## Running the tests
Run `bundle exec rspec` to run the test suite

## <ins>Contributors</ins>
<p>
  <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />
</p>

- [Darren Kulback](https://www.linkedin.com/in/darren-kulback-9b2394189/)

<p>
  <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" />
</p>

- [Darren Kulback](https://github.com/dkulback)
## IDE
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
