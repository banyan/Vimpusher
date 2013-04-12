Vimpusher [![Build Status](https://secure.travis-ci.org/banyan/Vimpusher.png)](http://travis-ci.org/banyan/Vimpusher)
==============================================
![Alt text](https://github.com/banyan/banyan.github.com/raw/master/images/vimpusher/vimpusher-girl.png)

URL
------------------------------
[http://www.vimpusher.com](http://www.vimpusher.com)

Overview
------------------------------
Vimpusher is social vim plugin service.

Quick Start
------------------------------

1. Prepare mysql server and redis server.
2. $ bundle install
3. Create below configs from \*.yml.sample files
    * config/database.yml
    * config/oauth.yml
    * config/redis.yml
4. $ RAILS\_ENV=production rake db:setup
5. $ RAILS\_ENV=production rake resque:work
6. $ script/rails server -e production [-p PORT]
7. Register application to OAuth providers
    * Callback URLs: /auth/{twitter,facebook,github}/callback

Copyright
------------------------------

MIT License
