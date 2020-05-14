# NranoTwitter tutorial 

This project is a clone of Twitter which implements the following functionalities:

* Register, log in/log out
* Homepage
* Tweet with tags
* Follow/unfollow
* Search by phrase
* Search by tag

They are implemented by the routes defined in the ruby files under `app/controllers`. 

# Getting Started

This project is built with Sinatra framework with ruby 2.6.5. The dependencies are specified in the Gemfile. In addition, the package management tools such as `gem` and `bundle` are required. 

## Installing

In `/NanoTwitter`, run

```
bundle install
```

to intall all the dependencies.

## Running

The project is run with `config.ru`, which allows different rack handlers to be used as application servers(Puma, Passenger, Unicorn, etc). This project uses puma as its application server and can be run with

```
cd NanoTwitter
bundle exec puma
```

or we can specify a port number and run the application with

```
bundle exec puma -p 3000
```

## Testing

The test routes can be found in app/controllers/tests_controller.rb. The two most important test routes are `/test/tweet` and `test/validate`. the first route is a functional test of tweeting, the latter is an integration test of following, tweeting and checking if the tweets appear on the follower's timeline.

## Deployment

```
doctl compute ssh frontend-sinatra
# switch to rails user
sudo -i -u rails
# grab your code for github
git clone $REPO
cd NanoTwitter
# install all your gems
bundle install
# switch back to root user
```

```
# As root user
sudo systemctl edit --full rails.service
```

```
[Unit]
Description=ServiceAPIApp
Requires=network.target

[Service]
Type=simple
User=rails
Group=rails
WorkingDirectory=/home/rails/NanoTwitter
ExecStart=/bin/bash -lc 'bundle exec puma'
TimeoutSec=30s
RestartSec=30s
Restart=always

[Install]
WantedBy=multi-user.target
```


