Engine.IO chat study
====================

- https://github.com/shokai/engineio-chat-study
- [demo](http://engineio-chat-study.herokuapp.com)

## Install Dependencies

    % npm install


## Build

    % grunt build


## Run

    % export PORT=5000
    % npm start

=> http://localhost:5000


## Deploy on Heroku

    % heroku create
    % heroku labs:enable websockets
    % git push heroku master
    % heroku open
